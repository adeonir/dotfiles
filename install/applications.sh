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
  curl \
  docker \
  docker-compose \
  fnm \
  gh \
  git \
  httpie \
  mysql \
  node \
  openssl \
  php \
  postgresql \
  python3 \
  readline \
  ruby \
  sqlite \
  starship \
  tree \
  vercel-cli \
  wget \
  zsh
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

# zinit
if (test ! -d $HOME/.local/share/zinit); then
  msg_install "Installing zinit"
  sh -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
  msg_ok "zinit installed"
else
  msg_alert "zinit already installed"
fi
