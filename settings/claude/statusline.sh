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

# Context window usage percentage
context_size=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')

# Sum all token types that contribute to context usage
input_tokens=$(echo "$input" | jq '.context_window.current_usage.input_tokens // 0')
cache_creation_tokens=$(echo "$input" | jq '.context_window.current_usage.cache_creation_input_tokens // 0')
cache_read_tokens=$(echo "$input" | jq '.context_window.current_usage.cache_read_input_tokens // 0')
output_tokens=$(echo "$input" | jq '.context_window.current_usage.output_tokens // 0')

# Total tokens = input + cache_creation + cache_read + output (fixed 2026-02-21)
total_tokens=$((input_tokens + cache_creation_tokens + cache_read_tokens + output_tokens))

if [[ $total_tokens -eq 0 ]]; then
  context_percent="--"
else
  context_percent=$((total_tokens * 100 / context_size))
  [[ $context_percent -gt 100 ]] && context_percent=100
fi

# Usage tracking via Anthropic API (with caching)
CACHE_DIR="$HOME/.cache/claude-statusline"
CACHE_FILE="$CACHE_DIR/usage-api.json"
CACHE_TTL=30

mkdir -p "$CACHE_DIR"

session_percent="--"
weekly_percent="--"
extra_percent="--"

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
  extra_percent=$(jq -r '.extra // "--"' "$CACHE_FILE")
else
  # Fetch fresh data from Anthropic API (run in background)
  (
    # Get credentials from keychain (hex-encoded since ~2026-02)
    creds_raw=$(security find-generic-password -s "Claude Code-credentials" -w 2>/dev/null)
    if [[ -n "$creds_raw" ]]; then
      # Decode hex, strip control characters, wrap as valid JSON
      creds_decoded=$(echo "$creds_raw" | xxd -r -p | tr -d '\000-\037')
      access_token=$(echo "{${creds_decoded}}" | perl -ne 'print $1 if /"accessToken":"([^"]+)"/')

      if [[ -n "$access_token" ]]; then
        response=$(curl -s -X GET "https://api.anthropic.com/api/oauth/usage" \
          -H "Authorization: Bearer $access_token" \
          -H "anthropic-beta: oauth-2025-04-20" \
          -H "User-Agent: claude-code/2.1.2" \
          -H "Accept: application/json")

        if echo "$response" | jq -e '.five_hour' >/dev/null 2>&1; then
          five_hour=$(echo "$response" | jq -r '.five_hour.utilization // 0')
          seven_day=$(echo "$response" | jq -r '.seven_day.utilization // 0')
          extra_usage=$(echo "$response" | jq -r '.extra_usage.utilization // 0')

          session_pct=$(printf "%.0f" "$five_hour" 2>/dev/null || echo "0")
          weekly_pct=$(printf "%.0f" "$seven_day" 2>/dev/null || echo "0")
          extra_pct=$(printf "%.0f" "$extra_usage" 2>/dev/null || echo "0")

          [[ $session_pct -gt 100 ]] && session_pct=100
          [[ $weekly_pct -gt 100 ]] && weekly_pct=100
          [[ $extra_pct -gt 100 ]] && extra_pct=100

          echo "{\"session\": \"${session_pct}\", \"weekly\": \"${weekly_pct}\", \"extra\": \"${extra_pct}\"}" > "$CACHE_FILE"
        fi
      fi
    fi
  ) &

  # Use stale cache if available
  if [[ -f "$CACHE_FILE" ]]; then
    session_percent=$(jq -r '.session // "--"' "$CACHE_FILE")
    weekly_percent=$(jq -r '.weekly // "--"' "$CACHE_FILE")
    extra_percent=$(jq -r '.extra // "--"' "$CACHE_FILE")
  fi
fi

# Build output
output=""
output+="\033[1;34m${dir_display}\033[0m"
output+=" \033[0;37m|\033[0m \033[0;33m${model}\033[0m"
output+=" \033[0;37m|\033[0m \033[0;36m${context_percent}% context\033[0m"
output+=" \033[0;37m|\033[0m \033[0;32m${session_percent}% session\033[0m"
output+=" \033[0;37m|\033[0m \033[0;35m${weekly_percent}% weekly\033[0m"
output+=" \033[0;37m|\033[0m \033[0;31m${extra_percent}% extra\033[0m"

printf "%b" "$output"
