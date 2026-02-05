#!/bin/sh

# Environment setup script
# Installs and configures the development environment:
#
# This script can be run independently or via install.sh

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

# Source initialization script
source "$SCRIPT_DIR/init.sh"

# Brew
echo
msg_install "Setting up Homebrew"
if ! command -v brew >/dev/null 2>&1; then
  msg_install_item "Installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  msg_ok 'Homebrew installed'
  msg_info 'Please restart your shell to continue'
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
  "eza"
  "fnm"
  "fzf"
  "gh"
  "git"
  "jq"
  "node"
  "pnpm"
  "starship"
  "tree"
  "uv"
  "wget"
  "zoxide"
  "zsh"
  "zsh-syntax-highlighting"
  "zsh-autosuggestions"
  "zsh-completions"
  "zsh-history-substring-search"
)

for tool in "${tools[@]}"; do
  if brew list "$tool" &>/dev/null; then
    msg_info "$tool already installed"
  else
    msg_install_item "Installing $tool"
    brew install "$tool"
    msg_ok "$tool installed"
  fi
done

# Fnm
msg_config "Setting Homebrew Node as fnm default"
fnm default system
msg_ok "fnm default configured"

# Bun
if [ ! -d "$HOME/.bun" ]; then
  msg_install_item "Installing Bun"
  curl -fsSL https://bun.sh/install | bash
  msg_ok "Bun installed"
else
  msg_info "Bun already installed"
fi

# oh-my-zsh
if (test ! -d "$HOME/.oh-my-zsh"); then
  msg_install_item "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  msg_ok "oh-my-zsh installed"
else
  msg_info "oh-my-zsh already installed"
fi
