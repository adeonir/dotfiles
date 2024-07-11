#!/bin/bash

DOTFILES="$HOME/www/projects/dotfiles"

if [[ -d $DOTFILES ]]; then
  echo 'Checking dotfiles directory'
else
  echo 'Cloning dotfiles'
  git clone https://github.com/adeonir/dotfiles.git $DOTFILES
fi

cd $DOTFILES

source install/environment.sh
source install/softwares.sh
source install/extensions.sh
source install/settings.sh
