#!/bin/sh

set -e

source colors.sh

#  Brew Cask
echo
msg_install "Installing software with brew cask"
cask=(
  "1password-cli"
  "1password"
  "arc"
  "catch"
  "chatgpt"
  "claude"
  "clockify"
  "cursor"
  "discord"
  "figma"
  "font-fira-code-nerd-font"
  "ghostty"
  "google-chrome"
  "notion"
  "obsidian"
  "orbstack"
  "raycast"
  "setapp"
  "slack"
  "spotify"
  "telegram"
  "visual-studio-code"
  "warp"
  "whatsapp"
  "yaak"
  "zen-browser"
)

for app in "${cask[@]}"; do
  if brew list --cask $app &>/dev/null; then
    msg_info "$app already installed"
  else
    msg_install_item "Installing $app"
    brew install --cask $app
    msg_ok "$app installed"
  fi
done
