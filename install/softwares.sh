#!/bin/sh

source colors.sh

#  Brew Cask
msg_install "Installing software with brew cask"
cask=(
  "1password"
  "android-studio"
  "arc"
  "chatgpt"
  "clockify"
  "discord"
  "docker"
  "figma"
  "font-fira-code-nerd-font"
  "flutter"
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
  "zoom"
)

for app in "${cask[@]}"; do
  msg_install "Installing $app"
  brew install --cask $app
  msg_ok "$app installed"
done

# BetterVim
msg_alert "What is the license key for BetterVim?"
read BETTER_VIM_LICENSE

if [ -z "$BETTER_VIM_LICENSE" ]; then
  msg_alert "BETTER_VIM_LICENSE is not set"
else
  if [ -f "$HOME/.config/better-vim/better-vim.lua" ]; then
      msg_update "better-vim"
      rm ~/.config/better-vim/better-vim.lua
  else
      msg_install "better-vim"
  fi
fi

ln -sf $DOTFILES/settings/better-vim/better-vim.lua ~/.config/better-vim/
msg_checking "better-vim"
