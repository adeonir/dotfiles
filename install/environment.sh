#!/bin/sh

set -e

source colors.sh

# Brew
echo
msg_install "Setting up Homebrew"
if ! command -v brew >/dev/null 2>&1; then
  msg_install "Installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  msg_ok 'Homebrew installed'
  exec "$SHELL"
else
  msg_info "Homebrew already installed"
fi

echo
msg_update "Updating Homebrew"
brew update
brew upgrade

# Command Line Tools
echo
msg_install "Installing command line tools with brew"
brew cleanup
brew tap buo/cask-upgrade

tools=(
  "bat"
  "curl"
  "fnm"
  "fzf"
  "gh"
  "git"
  "jq"
  "node"
  "pnpm"
  "starship"
  "tldr"
  "tree"
  "wget"
  "zoxide"
  "zsh"
  "zsh-syntax-highlighting"
  "zsh-autosuggestions"
  "zsh-completions"
  "zsh-history-substring-search"
)

for tool in "${tools[@]}"; do
  if brew list $tool &>/dev/null; then
    msg_info "$tool already installed"
  else
    msg_install "Installing $tool"
    brew install $tool
    msg_ok "$tool installed"
  fi
done

# Fnm
fnm default system

# Bun
if [ ! -d $HOME/.bun ]; then
  msg_install "Installing Bun"
  curl -fsSL https://bun.sh/install | bash
  msg_ok "Bun installed"
else
  msg_info "Bun already installed"
fi

# oh-my-zsh
if (test ! -d $HOME/.oh-my-zsh); then
  msg_install "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  msg_ok "oh-my-zsh installed"
else
  msg_info "oh-my-zsh already installed"
fi
