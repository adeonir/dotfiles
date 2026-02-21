# Hide 'last login' message
printf '\33c\e[3J'

# Paths
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.fnm:$PATH"
export PATH="$HOME/.bun/bin:$PATH"
export PATH="$HOME/.pnpm:$PATH"
export PATH="$HOME/.console-ninja/.bin:$PATH"
export PATH="$HOME/.codeium/windsurf/bin:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/lib:$PATH"

# Environment variables
export ZSH="$HOME/.oh-my-zsh"
export BUN_INSTALL="$HOME/.bun"
export PNPM_HOME="$HOME/.pnpm"
export NPM_CONFIG_LOGLEVEL=error
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export EDITOR="windsurf --wait"

# Oh-my-zsh plugins
plugins=(
  brew
  docker
  git
  github
  macos
  node
  npm
  zoxide
)

# Sources
source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
source $HOME/.functions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
[ -f "$HOME/.secrets" ] && source $HOME/.secrets

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Zsh options
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY

# Zsh key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Completions
fpath=($HOME/.docker/completions $fpath)
autoload -Uz compinit
compinit

# Initializations
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd --version-file-strategy=recursive --log-level=quiet)"
