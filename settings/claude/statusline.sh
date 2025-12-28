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
  # Replace home with ~
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

# Node.js version
node_info=""
if command -v node &> /dev/null; then
  node_version=$(node --version 2>/dev/null)
  if [[ -n "$node_version" ]]; then
    node_info="$node_version"
  fi
fi

# Model name
model=$(echo "$input" | jq -r '.model.display_name // "Claude"')

# Context window usage percentage
context_size=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')
usage=$(echo "$input" | jq -r '.context_window.current_usage // empty')
context_percent="0"
if [[ -n "$usage" && "$usage" != "null" ]]; then
  tokens=$(echo "$usage" | jq '(.input_tokens // 0) + (.cache_creation_input_tokens // 0) + (.cache_read_input_tokens // 0)')
  context_percent=$((tokens * 100 / context_size))
fi

# Build left side
left_side=""
left_plain=""

left_side+="\033[1;34m${dir_display}\033[0m"
left_plain+="$dir_display"

if [[ -n "$git_info" ]]; then
  left_side+=" \033[0;37m|\033[0m \033[1;35m${git_info}\033[0m"
  left_plain+=" | ${git_info}"
fi

if [[ -n "$node_info" ]]; then
  left_side+=" \033[0;37m|\033[0m \033[0;32m${node_info}\033[0m"
  left_plain+=" | ${node_info}"
fi

# Build right side
right_side="\033[0;33m${model}\033[0m \033[0;37m|\033[0m \033[0;36m${context_percent}%%\033[0m"
right_plain="${model} | ${context_percent}%"

# Calculate padding for right alignment
term_width=$(tput cols 2>/dev/null || echo 80)
left_len=${#left_plain}
right_len=${#right_plain}
padding=$((term_width - left_len - right_len))

if [[ $padding -lt 1 ]]; then
  padding=1
fi

# Output
printf "%b%*s%b" "$left_side" "$padding" "" "$right_side"
