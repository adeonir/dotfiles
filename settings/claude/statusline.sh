#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract current directory from JSON
cwd=$(echo "$input" | jq -r '.workspace.current_dir')

# Change to the working directory
cd "$cwd" 2>/dev/null || cd "$HOME"

# Directory with truncation (keep last 2 parts)
current_dir=$(pwd)
if [[ "$current_dir" == "$HOME" ]]; then
  dir_display="~"
elif [[ "$current_dir" == "$HOME"/* ]]; then
  dir_display="~${current_dir#$HOME}"
else
  dir_display="$current_dir"
fi

if [[ $(echo "$dir_display" | grep -o "/" | wc -l) -gt 2 ]]; then
  dir_display="../$(echo "$dir_display" | rev | cut -d'/' -f1,2 | rev)"
fi

# Model name
model=$(echo "$input" | jq -r '.model.display_name // "Claude"')

# Context window usage (pre-calculated by Claude Code)
context_percent=$(echo "$input" | jq -r '.context_window.used_percentage // "--"')

# Usage tracking via Anthropic API (with caching)
CACHE_DIR="$HOME/.cache/claude-statusline"
CACHE_FILE="$CACHE_DIR/usage-api.json"
CACHE_TTL=120

mkdir -p "$CACHE_DIR"

session_percent="--"
weekly_percent="--"

# Check if cache is valid
cache_valid=false
if [[ -f "$CACHE_FILE" ]]; then
  cache_age=$(($(date +%s) - $(stat -f %m "$CACHE_FILE" 2>/dev/null || echo 0)))
  if [[ $cache_age -lt $CACHE_TTL ]]; then
    cache_valid=true
  fi
fi

if [[ "$cache_valid" == "true" ]]; then
  session_percent=$(jq -r '.session // "--"' "$CACHE_FILE")
  weekly_percent=$(jq -r '.weekly // "--"' "$CACHE_FILE")
else
  # Fetch fresh data from Anthropic API (run in background)
  (
    # Get credentials from keychain
    creds_raw=$(security find-generic-password -s "Claude Code-credentials" -w 2>/dev/null)
    if [[ -z "$creds_raw" ]]; then
      exit 0
    fi

    # Try JSON directly first, fall back to hex decoding
    if echo "$creds_raw" | jq -e '.claudeAiOauth.accessToken' >/dev/null 2>&1; then
      access_token=$(echo "$creds_raw" | jq -r '.claudeAiOauth.accessToken')
    else
      creds_decoded=$(echo "$creds_raw" | xxd -r -p | LC_ALL=C tr -d '\000-\037')
      access_token=$(echo "{${creds_decoded}}" | perl -ne 'print $1 if /"accessToken":"([^"]+)"/')
    fi

    if [[ -z "$access_token" ]]; then
      exit 0
    fi

    response=$(curl -s -X GET "https://api.anthropic.com/api/oauth/usage" \
      -H "Authorization: Bearer $access_token" \
      -H "anthropic-beta: oauth-2025-04-20" \
      -H "User-Agent: claude-code/2.1.2" \
      -H "Accept: application/json")

    if echo "$response" | jq -e '.five_hour' >/dev/null 2>&1; then
      five_hour=$(echo "$response" | jq -r '.five_hour.utilization // 0')
      seven_day=$(echo "$response" | jq -r '.seven_day.utilization // 0')
      session_pct=$(printf "%.0f" "$five_hour" 2>/dev/null || echo "0")
      weekly_pct=$(printf "%.0f" "$seven_day" 2>/dev/null || echo "0")

      [[ $session_pct -gt 100 ]] && session_pct=100
      [[ $weekly_pct -gt 100 ]] && weekly_pct=100

      echo "{\"session\": \"${session_pct}\", \"weekly\": \"${weekly_pct}\"}" > "$CACHE_FILE"
    fi
  ) &

  # Use stale cache if available
  if [[ -f "$CACHE_FILE" ]]; then
    session_percent=$(jq -r '.session // "--"' "$CACHE_FILE")
    weekly_percent=$(jq -r '.weekly // "--"' "$CACHE_FILE")
  fi
fi

# Git branch
branch=$(git symbolic-ref --short HEAD 2>/dev/null || echo "")

# Build output (2 lines)
line1="\033[1;34m${dir_display}\033[0m"
if [[ -n "$branch" ]]; then
  line1+=" \033[0;37mon\033[0m \033[1;35m${branch}\033[0m"
fi

line2="\033[0;33m${model}\033[0m"
line2+=" \033[0;37m|\033[0m \033[38;5;214m${context_percent}% context\033[0m"
line2+=" \033[0;37m|\033[0m \033[38;5;75m${session_percent}% session\033[0m"
line2+=" \033[0;37m|\033[0m \033[38;5;114m${weekly_percent}% weekly\033[0m"

echo -e "$line2"
echo -e "$line1"
