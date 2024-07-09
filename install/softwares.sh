#!/bin/sh

source colors.sh

#  Brew Cask
msg_install "Installing software with brew cask"
cask=(
  "arc"
  "bitwarden"
  "chatgpt"
  "clockify"
  "discord"
  "docker"
  "figma"
  "font-fira-code-nerd-font"
  "google-chrome"
  "google-chrome@dev"
  "google-drive"
  "lulu"
  "notion"
  "raycast"
  "setapp"
  "slack"
  "spotify"
  "telegram"
  "transmission"
  "visual-studio-code"
  "warp"
  "whatsapp"
  "yandex-disk"
  "zoom"
)

for app in "${cask[@]}"; do
  msg_install "Installing $app"
  brew install --cask $app
  msg_ok "$app installed"
done

# BetterVim
if [ -z "$BETTER_VIM_LICENSE" ]; then
  msg_alert "BETTER_VIM_LICENSE is not set"
else
  msg_install "Installing BetterVim"
  curl -L "https://bettervim.com/install/$BETTER_VIM_LICENSE" | bash
  msg_ok "BetterVim installed"
fi
