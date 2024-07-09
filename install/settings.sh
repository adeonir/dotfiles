#!/bin/sh

source colors.sh

ln -sf $DOTFILES/settings/.zshrc ~/
msg_checking ".zshrc"

# .editorconfig
if [ -f "$HOME/.editorconfig" ]; then
    msg_update ".editorconfig"
    rm ~/.editorconfig
else
    msg_install ".editorconfig"
fi

ln -sf $DOTFILES/settings/.editorconfig ~/
msg_checking ".editorconfig"

# .gitconfig
if [ -f "$HOME/.gitconfig" ]; then
    msg_update ".gitconfig"
    rm ~/.gitconfig
    rm ~/.gitignore
else
    msg_install ".gitconfig"
fi

ln -sf $DOTFILES/settings/.gitconfig ~/
ln -sf $DOTFILES/settings/.gitignore ~/
msg_checking ".gitconfig"

# .aliases
if [ -f "$HOME/.aliases" ]; then
    msg_update ".aliases"
    rm ~/.aliases
else
    msg_install ".aliases"
fi

ln -sf $DOTFILES/settings/.aliases ~/
msg_checking ".aliases"

# .functions
if [ -f "$HOME/.functions" ]; then
    msg_update ".functions"
    rm ~/.functions
else
    msg_install ".functions"
fi

ln -sf $DOTFILES/settings/.functions ~/
msg_checking ".functions"

# .npmrc
if [ -f "$HOME/.npmrc" ]; then
    msg_update ".npmrc"
    rm ~/.npmrc
else
    msg_install ".npmrc"
fi

ln -sf $DOTFILES/settings/.npmrc ~/
msg_checking ".npmrc"

# BetterVim
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

# Warp theme
if [ -f "$HOME/.warp/themes/catppuccin_macchiato.yml" ]; then
    msg_update "warp theme"
    rm ~/.warp/themes/catppuccin_macchiato.yml
else
    msg_install "warp theme"
fi

ln -sf $DOTFILES/settings/.warp/themes/catppuccin_macchiato.yml ~/.warp/themes/
msg_checking "warp theme"

# Starship
if [ -f "$HOME/.config/starship.toml" ]; then
    msg_update "starship"
    rm ~/.config/starship.toml
else
    msg_install "starship"
fi

ln -sf $DOTFILES/settings/starship.toml ~/.config/
msg_checking "starship"

# .zshrc
if [ -f "$HOME/.zshrc" ]; then
    msg_update ".zshrc"
    rm ~/.zshrc
else
    msg_install ".zshrc"
fi

ln -sf $DOTFILES/settings/.zshrc ~/
msg_checking ".zshrc"
