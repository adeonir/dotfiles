# Path
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/lib:$PATH"

# Xterm config
export TERM=xterm-256color

# Fix lint-staged spinners and colors
export FORCE_COLOR=1

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Path sourses
source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
source $HOME/.functions

# Zsh plugins
plugins=(
  z
  git
  vscode
  brew
  node
  yarn
  npm
  docker
  github
  macos
)

# Zsh history settings
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000

setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY

# Zsh key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit ice wait
zinit for \
    light-mode zsh-users/zsh-apple-touchbar \
    light-mode zsh-users/zsh-autosuggestions \
    light-mode zsh-users/zsh-completions \
    light-mode zsh-users/zsh-history-substring-search \
    light-mode zsh-users/zsh-syntax-highlighting \
    light-mode zdharma-continuum/fast-syntax-highlighting \
    light-mode zdharma-continuum/history-search-multi-word \
    load agkozak/zsh-z
# Zinit end

# Starship
eval "$(starship init zsh)"

# Fnm
eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
# Bun end

# Pnpm
export PNPM_HOME="$HOME/.pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# Pnpm end

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Ruby
export PATH=/opt/homebrew/opt/ruby/bin:$PATH
export PATH=`gem environment gemdir`/bin:$PATH

# Console Ninja
PATH=$HOME/.console-ninja/.bin:$PATH

# Flutter
export PATH=$HOME/.flutter/bin:$PATH

# CocoaPods
export PATH=$HOME/.gem/bin:$PATH

# Openjdk
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
