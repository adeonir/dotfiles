#!/bin/sh

# VSCode extensions installation script
# Installs VSCode extensions from extensions.txt file:
#
# This script can be run independently or via install.sh

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

# Source initialization script
source "$SCRIPT_DIR/init.sh"

EXTENSIONS_FILE="$DOTFILES/settings/vscode/extensions.txt"

if [ ! -f "$EXTENSIONS_FILE" ]; then
  msg_error "Extensions file not found: $EXTENSIONS_FILE"
  exit 1
fi

echo
msg_install "Installing VSCode extensions"

while IFS= read -r extension || [ -n "$extension" ]; do
  if [ -z "$extension" ] || [ "${extension:0:1}" = "#" ]; then
    continue
  fi

  if code --list-extensions 2>/dev/null | grep -q "^${extension}$"; then
    msg_info "$extension already installed"
  else
    msg_install_item "Installing $extension"
    code --install-extension "$extension" --force >/dev/null 2>&1 || true
    msg_ok "$extension installed"
  fi
done < "$EXTENSIONS_FILE"
