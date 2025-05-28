#!/bin/sh

source colors.sh

# Brew
msg_install "Setting up Homebrew"
if test ! $(which brew); then
  msg_install "Installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  msg_ok 'Homebrew installed'
  exec "$SHELL"
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
  bat \
  curl \
  fnm \
  gh \
  git \
  node \
  pnpm \
  starship \
  tree \
  wget \
  zsh \
  zsh-syntax-highlighting \
  zsh-autosuggestions \
  zsh-completions \
  zsh-history-substring-search
msg_ok "Apps installed"

# Fnm
fnm default system

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
