#!/bin/sh

source colors.sh

# Vscode settings
if [ -f "$HOME/Library/Application\ Support/Code/User/settings.json" ]; then
  msg_update "vscode settings"
  rm $HOME/Library/Application\ Support/Code/User/settings.json
else
  msg_install "vscode settings"
fi
ln -sf $DOTFILES/settings/vscode/settings.json $HOME/Library/Application\ Support/Code/User/
msg_checking "vscode settings"

# .editorconfig
if [ -f "$HOME/.editorconfig" ]; then
  msg_update ".editorconfig"
  rm $HOME/.editorconfig
else
  msg_install ".editorconfig"
fi
ln -sf $DOTFILES/settings/.editorconfig $HOME/
msg_checking ".editorconfig"

# .gitconfig
if [ -f "$HOME/settings/git/.gitconfig" ]; then
  msg_update ".gitconfig"
  rm $HOME/.gitconfig
else
  msg_install ".gitconfig"
fi
ln -sf $DOTFILES/settings/git/.gitconfig $HOME/
msg_checking ".gitconfig"

# .gitignore
if [ -f "$HOME/settings/git/.gitignore" ]; then
  msg_update ".gitignore"
  rm $HOME/.gitignore
else
  msg_install ".gitignore"
fi
ln -sf $DOTFILES/settings/git/.gitignore $HOME/
msg_checking ".gitignore"

# .aliases
if [ -f "$HOME/.aliases" ]; then
  msg_update ".aliases"
  rm $HOME/.aliases
else
  msg_install ".aliases"
fi
ln -sf $DOTFILES/settings/.aliases $HOME/
msg_checking ".aliases"

# .functions
if [ -f "$HOME/.functions" ]; then
  msg_update ".functions"
  rm $HOME/.functions
else
  msg_install ".functions"
fi
ln -sf $DOTFILES/settings/.functions $HOME/
msg_checking ".functions"

# .npmrc
if [ -f "$HOME/.npmrc" ]; then
  msg_update ".npmrc"
  rm $HOME/.npmrc
else
  msg_install ".npmrc"
fi
ln -sf $DOTFILES/settings/.npmrc $HOME/
msg_checking ".npmrc"

# Warp theme
if [ -f "$HOME/.warp/themes/catppuccin_macchiato.yml" ]; then
  msg_update "warp theme"
  rm $HOME/.warp/themes/catppuccin_macchiato.yml
else
  msg_install "warp theme"
fi
ln -sf $DOTFILES/settings/warp/catppuccin_macchiato.yml $HOME/.warp/themes/
msg_checking "warp theme"

# Starship
if [ -f "$HOME/.config/starship.toml" ]; then
  msg_update "starship"
  rm $HOME/.config/starship.toml
else
  msg_install "starship"
fi
ln -sf $DOTFILES/settings/starship.toml $HOME/.config/
msg_checking "starship"

# .zprofile
if [ -f "$HOME/.zprofile" ]; then
  msg_update ".zprofile"
  rm $HOME/.zprofile
else
  msg_install ".zprofile"
fi
ln -sf $DOTFILES/settings/.zprofile $HOME/
msg_checking ".zprofile"

# .zshrc
if [ -f "$HOME/.zshrc" ]; then
  msg_update ".zshrc"
  rm $HOME/.zshrc
else
  msg_install ".zshrc"
fi
ln -sf $DOTFILES/settings/.zshrc $HOME/
msg_checking ".zshrc"
