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

# BetterVim Configuration
msg_prompt "What is the license key for BetterVim?"
read BETTER_VIM_LICENSE

if [ -n "$BETTER_VIM_LICENSE" ]; then
  if [ -f "$HOME/.config/better-vim/better-vim.lua" ]; then
    msg_update "better-vim"
    rm ~/.config/better-vim/better-vim.lua
  else
    msg_install_item "better-vim"
    mkdir -p ~/.config/better-vim
  fi
  ln -sf $DOTFILES/settings/better-vim/better-vim.lua ~/.config/better-vim/
  msg_checking "better-vim"
else
  msg_skip "BetterVim - no license key provided"
fi
