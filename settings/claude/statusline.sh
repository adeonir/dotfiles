#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract current directory from JSON
cwd=$(echo "$input" | jq -r '.workspace.current_dir')

# Change to the working directory
cd "$cwd" 2>/dev/null || cd "$HOME"

# Directory with truncation (similar to Starship config)
current_dir=$(pwd)
if [[ "$current_dir" == "$HOME" ]]; then
  dir_display="~"
elif [[ "$current_dir" == "$HOME"/* ]]; then
  dir_display="~${current_dir#$HOME}"
else
  dir_display="$current_dir"
fi

# Truncate directory (keep last 2 parts like Starship truncation_length = 2)
if [[ $(echo "$dir_display" | grep -o "/" | wc -l) -gt 2 ]]; then
  dir_display="../$(echo "$dir_display" | rev | cut -d'/' -f1,2 | rev)"
fi

# Git branch with icon (matching Starship git_branch symbol)
git_info=""
if git rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git branch --show-current 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  if [[ -n "$branch" ]]; then
    git_info="$branch"
  fi
fi

# Model name
model=$(echo "$input" | jq -r '.model.display_name // "Claude"')

# Context window usage percentage
context_size=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')
usage=$(echo "$input" | jq -r '.context_window.current_usage // empty')
context_percent="0"
if [[ -n "$usage" && "$usage" != "null" ]]; then
  input_total=$(echo "$usage" | jq '(.input_tokens // 0) + (.cache_creation_input_tokens // 0) + (.cache_read_input_tokens // 0)')
  output_total=$(echo "$usage" | jq '.output_tokens // 0')
  total_tokens=$((input_total + output_total))

  buffer=$((context_size * 23 / 100))
  threshold=$((context_size - buffer))

  context_percent=$((total_tokens * 100 / threshold))
  [[ $context_percent -gt 100 ]] && context_percent=100
fi

# Usage tracking via ccusage (with caching)
CACHE_DIR="$HOME/.cache/claude-statusline"
CACHE_FILE="$CACHE_DIR/usage.json"
CONFIG_FILE="$HOME/.claude/usage-config.json"
CACHE_TTL=30

mkdir -p "$CACHE_DIR"

# Default limits (Max5 plan)
LIMIT_5H=50
LIMIT_WEEKLY=500

# Load config if exists
if [[ -f "$CONFIG_FILE" ]]; then
  LIMIT_5H=$(jq -r '.limits["5h_cost_usd"] // 50' "$CONFIG_FILE")
  LIMIT_WEEKLY=$(jq -r '.limits["weekly_cost_usd"] // 500' "$CONFIG_FILE")
  CACHE_TTL=$(jq -r '.cache_ttl_seconds // 30' "$CONFIG_FILE")
fi

usage_5h="--"
usage_weekly="--"

# Check if cache is valid
cache_valid=false
if [[ -f "$CACHE_FILE" ]]; then
  cache_age=$(($(date +%s) - $(stat -f %m "$CACHE_FILE" 2>/dev/null || echo 0)))
  if [[ $cache_age -lt $CACHE_TTL ]]; then
    cache_valid=true
  fi
fi

if [[ "$cache_valid" == "true" ]]; then
  # Read from cache
  usage_5h=$(jq -r '.usage_5h // "--"' "$CACHE_FILE")
  usage_weekly=$(jq -r '.usage_weekly // "--"' "$CACHE_FILE")
else
  # Fetch fresh data from ccusage (run in background to not block)
  (
    # Get current 5h block
    block_data=$(npx --yes ccusage@latest blocks --json 2>/dev/null | jq '[.blocks[] | select(.isActive == true)] | .[0] // empty')
    block_cost=0
    if [[ -n "$block_data" && "$block_data" != "null" ]]; then
      block_cost=$(echo "$block_data" | jq -r '.costUSD // 0')
    fi

    # Get current week
    weekly_data=$(npx --yes ccusage@latest weekly --json 2>/dev/null | jq '.weekly[-1] // empty')
    weekly_cost=0
    if [[ -n "$weekly_data" && "$weekly_data" != "null" ]]; then
      weekly_cost=$(echo "$weekly_data" | jq -r '.totalCost // 0')
    fi

    # Calculate percentages
    if [[ -n "$block_cost" && "$block_cost" != "0" ]]; then
      pct_5h=$(echo "scale=0; $block_cost * 100 / $LIMIT_5H" | bc 2>/dev/null || echo "0")
      [[ $pct_5h -gt 100 ]] && pct_5h=100
    else
      pct_5h=0
    fi

    if [[ -n "$weekly_cost" && "$weekly_cost" != "0" ]]; then
      pct_weekly=$(echo "scale=0; $weekly_cost * 100 / $LIMIT_WEEKLY" | bc 2>/dev/null || echo "0")
      [[ $pct_weekly -gt 100 ]] && pct_weekly=100
    else
      pct_weekly=0
    fi

    # Write cache
    echo "{\"usage_5h\": \"${pct_5h}\", \"usage_weekly\": \"${pct_weekly}\", \"block_cost\": $block_cost, \"weekly_cost\": $weekly_cost}" > "$CACHE_FILE"
  ) &

  # Use stale cache if available, otherwise show placeholder
  if [[ -f "$CACHE_FILE" ]]; then
    usage_5h=$(jq -r '.usage_5h // "--"' "$CACHE_FILE")
    usage_weekly=$(jq -r '.usage_weekly // "--"' "$CACHE_FILE")
  fi
fi

# Build left side
left_side=""

left_side+="\033[1;34m${dir_display}\033[0m"

if [[ -n "$git_info" ]]; then
  left_side+=" \033[0;37m|\033[0m \033[1;35m${git_info}\033[0m"
fi

# Add model, context usage, and rate limits
left_side+=" \033[0;37m|\033[0m \033[0;33m${model}\033[0m"
left_side+=" \033[0;37m|\033[0m \033[0;36mctx ${context_percent}%\033[0m"
left_side+=" \033[0;37m|\033[0m \033[0;32m5h ${usage_5h}%\033[0m"
left_side+=" \033[0;37m|\033[0m \033[0;35m7d ${usage_weekly}%\033[0m"

# Output
printf "%b" "$left_side"
