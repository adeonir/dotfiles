#!/bin/sh

# Software installation script
# Installs GUI applications using Homebrew Cask:
#
# This script can be run independently or via install.sh

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

# Source initialization script
source "$SCRIPT_DIR/init.sh"

#  Brew Cask
echo
msg_install "Installing software with brew cask"
cask=(
  "1password-cli"
  "1password"
  "arc"
  "claude"
  "discord"
  "figma"
  "font-fira-code-nerd-font"
  "ghostty"
  "obsidian"
  "orbstack"
  "raycast"
  "setapp"
  "spotify"
  "telegram"
  "visual-studio-code"
  "whatsapp"
  "windsurf"
  "yaak"
)

for app in "${cask[@]}"; do
  if brew list --cask "$app" &>/dev/null; then
    msg_info "$app already installed"
  else
    msg_install_item "Installing $app"
    brew install --cask "$app"
    msg_ok "$app installed"
  fi
done
