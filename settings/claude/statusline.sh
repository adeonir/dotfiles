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
model=$(echo "$input" | jq -r '.model.display_name // "Claude"' | sed 's/ (\([^)]*\) context)/ \1/')

# Claude Code version (used in API User-Agent)
cli_version=$(echo "$input" | jq -r '.version // "2.1.76"')

# Session cost
session_cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
cost_display=$(awk -v c="$session_cost" 'BEGIN {
  if (c+0 < 0.005) printf "$0"
  else printf "$%.2f", c
}')

# Context window: size, percent, absolute tokens
window_size=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')
context_percent=$(echo "$input" | jq -r '.context_window.used_percentage // 0')

tokens_used=$(echo "$input" | jq -r '
  (.context_window.current_usage.input_tokens // 0) +
  (.context_window.current_usage.output_tokens // 0) +
  (.context_window.current_usage.cache_creation_input_tokens // 0) +
  (.context_window.current_usage.cache_read_input_tokens // 0)
')

if [[ "$tokens_used" == "0" && "$context_percent" != "0" ]]; then
  tokens_used=$(awk -v w="$window_size" -v p="$context_percent" 'BEGIN { printf "%d", (w*p)/100 }')
fi

tokens_display=$(awk -v n="$tokens_used" 'BEGIN {
  if (n >= 1000000) printf "%.1fM", n/1000000
  else if (n >= 1000) printf "%.1fk", n/1000
  else printf "0k"
}')

# Color thresholds for context (1M: 100k/250k, 200k: 50k/100k)
if [[ "$window_size" == "1000000" ]]; then
  yellow_max=100000
  orange_max=250000
else
  yellow_max=50000
  orange_max=100000
fi

if (( tokens_used < yellow_max )); then
  ctx_color="\033[0;33m"
elif (( tokens_used < orange_max )); then
  ctx_color="\033[38;5;214m"
else
  ctx_color="\033[38;5;203m"
fi

# Usage tracking via Anthropic API (with caching)
CACHE_DIR="$HOME/.cache/claude-statusline"
CACHE_FILE="$CACHE_DIR/usage-api.json"
CACHE_TTL=120

mkdir -p "$CACHE_DIR"

session_percent="--"
weekly_percent="--"
session_resets_at=""
weekly_resets_at=""

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
  session_resets_at=$(jq -r '.session_resets_at // ""' "$CACHE_FILE")
  weekly_resets_at=$(jq -r '.weekly_resets_at // ""' "$CACHE_FILE")
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
      -H "User-Agent: claude-code/${cli_version}" \
      -H "Accept: application/json")

    if echo "$response" | jq -e '.five_hour' >/dev/null 2>&1; then
      five_hour=$(echo "$response" | jq -r '.five_hour.utilization // 0')
      seven_day=$(echo "$response" | jq -r '.seven_day.utilization // 0')
      session_reset=$(echo "$response" | jq -r '.five_hour.resets_at // ""')
      weekly_reset=$(echo "$response" | jq -r '.seven_day.resets_at // ""')
      session_pct=$(awk -v v="$five_hour" 'BEGIN { printf "%d", (v == int(v) ? v : int(v) + 1) }')
      weekly_pct=$(awk -v v="$seven_day" 'BEGIN { printf "%d", (v == int(v) ? v : int(v) + 1) }')

      [[ $session_pct -gt 100 ]] && session_pct=100
      [[ $weekly_pct -gt 100 ]] && weekly_pct=100

      jq -n \
        --arg session "$session_pct" \
        --arg weekly "$weekly_pct" \
        --arg session_resets_at "$session_reset" \
        --arg weekly_resets_at "$weekly_reset" \
        '{session: $session, weekly: $weekly, session_resets_at: $session_resets_at, weekly_resets_at: $weekly_resets_at}' \
        > "$CACHE_FILE"
    fi
  ) &

  # Use stale cache if available
  if [[ -f "$CACHE_FILE" ]]; then
    session_percent=$(jq -r '.session // "--"' "$CACHE_FILE")
    weekly_percent=$(jq -r '.weekly // "--"' "$CACHE_FILE")
    session_resets_at=$(jq -r '.session_resets_at // ""' "$CACHE_FILE")
    weekly_resets_at=$(jq -r '.weekly_resets_at // ""' "$CACHE_FILE")
  fi
fi

# Format seconds as "4d2h", "1h12m", or "42m"
fmt_duration() {
  local diff="$1"
  if (( diff <= 0 )); then
    echo "0m"
    return
  fi
  local days=$((diff / 86400))
  local hours=$(( (diff % 86400) / 3600 ))
  local mins=$(( (diff % 3600) / 60 ))
  if (( days > 0 )); then
    printf "%dd%dh" "$days" "$hours"
  elif (( hours > 0 )); then
    printf "%dh%dm" "$hours" "$mins"
  else
    printf "%dm" "$mins"
  fi
}

# Format ISO 8601 timestamp as time-until: "4d2h", "1h12m", "42m", or "now"
fmt_until() {
  local target_iso="$1"
  if [[ -z "$target_iso" || "$target_iso" == "null" ]]; then
    echo "--"
    return
  fi
  local clean="${target_iso%%.*}"
  clean="${clean%%+*}"
  local target_ts
  target_ts=$(date -j -u -f "%Y-%m-%dT%H:%M:%S" "$clean" +%s 2>/dev/null) || { echo "--"; return; }
  local now_ts
  now_ts=$(date +%s)
  local diff=$((target_ts - now_ts))
  if (( diff <= 0 )); then
    echo "now"
    return
  fi
  echo "~$(fmt_duration "$diff")"
}

session_until=$(fmt_until "$session_resets_at")
weekly_until=$(fmt_until "$weekly_resets_at")

# Session duration
session_duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')
session_duration=$(fmt_duration "$((session_duration_ms / 1000))")

# Git branch
branch=$(git symbolic-ref --short HEAD 2>/dev/null || echo "")

# Build output (2 lines)
line1="\033[1;34m${dir_display}\033[0m"
if [[ -n "$branch" ]]; then
  line1+=" \033[0;37mon\033[0m \033[1;35m${branch}\033[0m"
fi
line1+=" \033[0;37mfor\033[0m \033[0;37m${session_duration}\033[0m"

sep="\033[0;37m|\033[0m"
dot="\033[0;37m·\033[0m"
line2="\033[1;37m${model}\033[0m"
line2+=" ${sep} ${ctx_color}${tokens_display}\033[0m ${dot} ${ctx_color}${context_percent}%\033[0m ${dot} \033[38;5;108m${cost_display}\033[0m"
line2+=" ${sep} \033[38;5;147m5h:${session_percent}% ${session_until}\033[0m"
line2+=" ${sep} \033[38;5;75m7d:${weekly_percent}% ${weekly_until}\033[0m"

echo -e "$line2"
echo -e "$line1"
