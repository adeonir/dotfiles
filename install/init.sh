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
