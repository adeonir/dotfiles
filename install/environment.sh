#!/bin/sh

source colors.sh

# Brew
msg_install "Setting up Homebrew"
if test ! $(which brew); then
  msg_install "Installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  msg_ok 'Homebrew installed'
else
  msg_alert "Homebrew already instaled"
  msg_update "Updating Homebrew"
  brew update
  brew upgrade
fi

# Brew apps
msg_install "Installing apps with brew"
brew cleanup
brew install \
  curl \
  gh \
  git \
  httpie \
  mysql \
  node \
  openssl \
  openssl@3 \
  postgresql@13 \
  pyenv \
  python3 \
  readline \
  rbenv \
  sqlite \
  sqlite3 \
  starship \
  tcl-tk \
  tree \
  vercel-cli \
  wget \
  zsh
msg_ok "Apps installed"

# Bun
msg_install "Installing Bun"
curl -fsSL https://bun.sh/install | bash
msg_ok "Bun installed"

# oh-my-zsh
msg_install "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
msg_ok "oh-my-zsh installed"

# zinit
msg_install "Installing zinit"
sh -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
msg_ok "zinit installed"

# nvm
msg_install "Installing NVM"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
msg_ok "NVM installed"
