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
    git_info=" $branch"

    # Git status indicators (matching Starship git_status)
    git_status=""
    if ! git diff --quiet 2>/dev/null; then
      git_status="${git_status}●" # Modified
    fi
    if ! git diff --cached --quiet 2>/dev/null; then
      git_status="${git_status}+" # Staged
    fi
    if [[ -n $(git ls-files --others --exclude-standard 2>/dev/null) ]]; then
      git_status="${git_status}?" # Untracked
    fi

    if [[ -n "$git_status" ]]; then
      git_info="$git_info $git_status"
    fi
  fi
fi

# Node.js version (matching Starship nodejs config)
node_info=""
if [[ -f "package.json" ]] && [[ ! -f "bun.lockb" ]]; then
  node_version=$(node --version 2>/dev/null)
  if [[ -n "$node_version" ]]; then
    node_info=" $node_version"
  fi
fi

# Output with blue color for directory (matching Starship config)
printf "\033[1;34m%s\033[0m" "$dir_display"

if [[ -n "$git_info" ]]; then
  printf " \033[0;37mon\033[0m\033[1;35m%s\033[0m" "$git_info"
fi

if [[ -n "$node_info" ]]; then
  printf " \033[0;37mvia\033[0m\033[0;32m%s\033[0m" "$node_info"
fi
