#!/bin/sh

# Settings configuration script
# Creates symlinks for configuration files:
#
# This script can be run independently or via install.sh

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

# Source initialization script
source "$SCRIPT_DIR/init.sh"

echo
msg_install "Installing settings files"

#=================
# APPLICATION CONFIGURATIONS
#================="

# Vscode settings
create_symlink "$DOTFILES/settings/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json" "vscode settings"

# Windsurf settings
create_symlink "$DOTFILES/settings/windsurf/settings.json" "$HOME/Library/Application Support/Windsurf/User/settings.json" "windsurf settings"

# Claude settings
create_symlink "$DOTFILES/settings/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md" "claude CLAUDE.md"

# Claude statusline
if [ -f "$HOME/.claude/statusline.sh" ]; then
  msg_info "claude statusline.sh already exists"
else
  msg_config "claude statusline.sh"
  mkdir -p "$HOME/.claude"
  ln -sf "$DOTFILES/settings/claude/statusline.sh" "$HOME/.claude/"
  chmod +x "$HOME/.claude/statusline.sh"
  msg_ok "claude statusline.sh configured"
fi

# Claude usage config (for statusline rate limit tracking)
create_symlink "$DOTFILES/settings/claude/usage-config.json" "$HOME/.claude/usage-config.json" "claude usage-config.json"

#=================
# GIT & EDITOR CONFIGURATIONS
#=================

# .gitconfig (global)
create_symlink "$DOTFILES/settings/git/.gitconfig" "$HOME/.gitconfig" ".gitconfig (global)"

# .gitignore
create_symlink "$DOTFILES/settings/git/.gitignore" "$HOME/.gitignore" ".gitignore"

# git-editor script
create_symlink "$DOTFILES/settings/bin/git-editor" "$HOME/.local/bin/git-editor" "git-editor script"

# .editorconfig
create_symlink "$DOTFILES/settings/.editorconfig" "$HOME/.editorconfig" ".editorconfig"

#=================
# SHELL CONFIGURATIONS
#=================

# .aliases
create_symlink "$DOTFILES/settings/.aliases" "$HOME/.aliases" ".aliases"

# .functions
create_symlink "$DOTFILES/settings/.functions" "$HOME/.functions" ".functions"

# .npmrc
create_symlink "$DOTFILES/settings/.npmrc" "$HOME/.npmrc" ".npmrc"

# .secrets
if [ -f "$HOME/.secrets" ]; then
  msg_info ".secrets already exists (preserving your API keys)"
else
  msg_config ".secrets"
  ln -sf "$DOTFILES/settings/.secrets" "$HOME/.secrets"
  msg_ok ".secrets created (remember to add your API keys)"
fi

# .zshrc
create_symlink "$DOTFILES/settings/.zshrc" "$HOME/.zshrc" ".zshrc"

# .zprofile
create_symlink "$DOTFILES/settings/.zprofile" "$HOME/.zprofile" ".zprofile"

# starship
create_symlink "$DOTFILES/settings/starship.toml" "$HOME/.config/starship.toml" "starship"

# ghostty
create_symlink "$DOTFILES/settings/ghostty/config" "$HOME/.config/ghostty/config" "ghostty config"
create_symlink "$DOTFILES/settings/ghostty/catppuccin-mocha" "$HOME/.config/ghostty/themes/catppuccin-mocha" "ghostty theme"

# warp
create_symlink "$DOTFILES/settings/warp/theme/catppuccin_mocha.yml" "$HOME/.warp/themes/catppuccin_mocha.yml" "warp theme"
