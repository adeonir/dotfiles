#!/bin/sh

source colors.sh

# Brew
msg_install "Setting up Homebrew"
if test ! $(which brew); then
  msg_install "Installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  msg_ok 'Homebrew installed'

  if [ -f ~/.bash_profile ]; then
    source ~/.bash_profile
  elif [ -f ~/.bashrc ]; then
    source ~/.bashrc
  fi
else
  msg_alert "Homebrew already installed"
fi

msg_update "Updating Homebrew"
brew update
brew upgrade

# Brew apps
msg_install "Installing apps with brew"
brew cleanup
brew tap buo/cask-upgrade
brew install \
  fnm \
  gh \
  git \
  httpie \
  mysql \
  node \
  openssl \
  openssl@3 \
  postgresql \
  pyenv \
  readline \
  rbenv \
  sqlite \
  starship \
  tcl-tk \
  tree \
  vercel-cli \
  wget \
  zsh
msg_ok "Apps installed"

# Fnm
fnm default system

# Ruby
rbenv install 3.3.4
rbenv global 3.3.4

# Python
pyenv install 3.12.5
pyenv global 3.12.5

# Bun
if [ ! -d $HOME/.bun ]; then
  msg_install "Installing Bun"
  curl -fsSL https://bun.sh/install | bash
  msg_ok "Bun installed"
else
  msg_alert "Bun already installed"
fi

# oh-my-zsh
if (test ! -d $HOME/.oh-my-zsh); then
  msg_install "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  msg_ok "oh-my-zsh installed"
else
  msg_alert "oh-my-zsh already installed"
fi

# zinit
if (test ! -d $HOME/.local/share/zinit); then
  msg_install "Installing zinit"
  sh -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
  msg_ok "zinit installed"
else
  msg_alert "zinit already installed"
fi
