#!/bin/bash

DOTFILES="$HOME/Developer/projects/dotfiles"

if [[ -d $DOTFILES ]]; then
  echo 'Checking dotfiles directory'
else
  echo 'Cloning dotfiles'
  git clone https://github.com/adeonir/dotfiles.git $DOTFILES
fi

cd $DOTFILES

source install/applications.sh
source install/softwares.sh
source install/settings.sh
