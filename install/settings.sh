#!/bin/sh

set -e

source colors.sh

echo
msg_install "Installing settings files"

#=================
# APPLICATION CONFIGURATIONS
#================="

# Vscode settings
if [ -f "$HOME/Library/Application\ Support/Code/User/settings.json" ]; then
  msg_update "vscode settings"
  rm $HOME/Library/Application\ Support/Code/User/settings.json
else
  msg_config "vscode settings"
fi
ln -sf $DOTFILES/settings/vscode/settings.json $HOME/Library/Application\ Support/Code/User/
msg_checking "vscode settings"

# Cursor settings
if [ -f "$HOME/Library/Application\ Support/Cursor/User/settings.json" ]; then
  msg_update "cursor settings"
  rm $HOME/Library/Application\ Support/Cursor/User/settings.json
else
  msg_config "cursor settings"
fi
ln -sf $DOTFILES/settings/cursor/settings.json $HOME/Library/Application\ Support/Cursor/User/
msg_checking "cursor settings"

# Claude settings
if [ -f "$HOME/.claude/CLAUDE.md" ]; then
  msg_update "claude CLAUDE.md"
  rm $HOME/.claude/CLAUDE.md
else
  msg_config "claude CLAUDE.md"
  mkdir -p $HOME/.claude
fi
ln -sf $DOTFILES/settings/claude/CLAUDE.md $HOME/.claude/
msg_checking "claude CLAUDE.md"

if [ -f "$HOME/.claude/settings.json" ]; then
  msg_update "claude settings.json"
  rm $HOME/.claude/settings.json
else
  msg_config "claude settings.json"
  mkdir -p $HOME/.claude
fi
ln -sf $DOTFILES/settings/claude/settings.json $HOME/.claude/
msg_checking "claude settings.json"

#=================
# GIT & EDITOR CONFIGURATIONS
#=================

# .gitconfig (global)
if [ -f "$HOME/settings/git/.gitconfig" ]; then
  msg_update ".gitconfig (global)"
  rm $HOME/.gitconfig
else
  msg_config ".gitconfig (global)"
fi
ln -sf $DOTFILES/settings/git/.gitconfig $HOME/
msg_checking ".gitconfig (global)"

# .gitconfig (joyjet)
if [ -f "$HOME/Developer/joyjet/.gitconfig" ]; then
  msg_update ".gitconfig (joyjet)"
  rm $HOME/Developer/joyjet/.gitconfig
else
  msg_config ".gitconfig (joyjet)"
  mkdir -p $HOME/Developer/joyjet
fi
ln -sf $DOTFILES/settings/joyjet/.gitconfig $HOME/Developer/joyjet/
msg_checking ".gitconfig (joyjet)"

# .gitignore
if [ -f "$HOME/settings/git/.gitignore" ]; then
  msg_update ".gitignore"
  rm $HOME/.gitignore
else
  msg_config ".gitignore"
fi
ln -sf $DOTFILES/settings/git/.gitignore $HOME/
msg_checking ".gitignore"

# .editorconfig
if [ -f "$HOME/.editorconfig" ]; then
  msg_update ".editorconfig"
  rm $HOME/.editorconfig
else
  msg_config ".editorconfig"
fi
ln -sf $DOTFILES/settings/.editorconfig $HOME/
msg_checking ".editorconfig"

#=================
# SHELL CONFIGURATIONS
#=================

# .aliases
if [ -f "$HOME/.aliases" ]; then
  msg_update ".aliases"
  rm $HOME/.aliases
else
  msg_config ".aliases"
fi
ln -sf $DOTFILES/settings/.aliases $HOME/
msg_checking ".aliases"

# .functions
if [ -f "$HOME/.functions" ]; then
  msg_update ".functions"
  rm $HOME/.functions
else
  msg_config ".functions"
fi
ln -sf $DOTFILES/settings/.functions $HOME/
msg_checking ".functions"

# .joyjet
if [ -f "$HOME/.joyjet" ]; then
  msg_update ".joyjet"
  rm $HOME/.joyjet
else
  msg_config ".joyjet"
fi
ln -sf $DOTFILES/settings/.joyjet $HOME/
msg_checking ".joyjet"

# .npmrc
if [ -f "$HOME/.npmrc" ]; then
  msg_update ".npmrc"
  rm $HOME/.npmrc
else
  msg_config ".npmrc"
fi
ln -sf $DOTFILES/settings/.npmrc $HOME/
msg_checking ".npmrc"

# .zshrc
if [ -f "$HOME/.zshrc" ]; then
  msg_update ".zshrc"
  rm $HOME/.zshrc
else
  msg_config ".zshrc"
fi
ln -sf $DOTFILES/settings/.zshrc $HOME/
msg_checking ".zshrc"

# .zprofile
if [ -f "$HOME/.zprofile" ]; then
  msg_update ".zprofile"
  rm $HOME/.zprofile
else
  msg_config ".zprofile"
fi
ln -sf $DOTFILES/settings/.zprofile $HOME/
msg_checking ".zprofile"

# starship
if [ -f "$HOME/.config/starship.toml" ]; then
  msg_update "starship"
  rm $HOME/.config/starship.toml
else
  msg_config "starship"
  mkdir -p $HOME/.config
fi
ln -sf $DOTFILES/settings/starship.toml $HOME/.config/
msg_checking "starship"

# ghostty
if [ -f "$HOME/.config/ghostty" ]; then
  msg_update "ghostty config"
  rm $HOME/.config/ghostty
else
  msg_config "ghostty config"
  mkdir -p $HOME/.config/ghostty
  mkdir -p $HOME/.config/ghostty/themes
fi
ln -sf $DOTFILES/settings/ghostty/config $HOME/.config/ghostty/
msg_checking "ghostty config"
ln -sf $DOTFILES/settings/ghostty/catppuccin-mocha $HOME/.config/ghostty/themes/catppuccin-mocha
msg_checking "ghostty theme"

# astronvim config
if [ -f "$HOME/.config/nvim/lua/plugins/astroui.lua" ]; then
  msg_update "astronvim config"
  cp -rf $DOTFILES/settings/astronvim/lua/* ~/.config/nvim/lua/
  msg_checking "astronvim config"
else
  msg_skip "astronvim config (AstroNvim not installed)"
fi
