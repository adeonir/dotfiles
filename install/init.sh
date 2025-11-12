#!/bin/sh

# Initialization script for dotfiles installation
# This script should be sourced at the beginning of each install script

set -e

# Detect DOTFILES directory if not already set
if [ -z "$DOTFILES" ]; then
  # Get the directory where this script is located
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
  # Go up one level to get the dotfiles root
  export DOTFILES="$(cd "$SCRIPT_DIR/.." && pwd)"
fi

# Source colors.sh for pretty output
if [ -f "$DOTFILES/colors.sh" ]; then
  source "$DOTFILES/colors.sh"
else
  echo "Error: colors.sh not found at $DOTFILES/colors.sh"
  exit 1
fi

# Helper function to create symlinks
create_symlink() {
  local source="$1"
  local target="$2"
  local description="$3"

  if [ -e "$target" ]; then
    msg_info "$description already exists"
  else
    msg_config "$description"
    mkdir -p "$(dirname "$target")"
    ln -sf "$source" "$target"
    msg_ok "$description configured"
  fi
}
