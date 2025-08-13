# Hide 'last login' message
printf '\33c\e[3J'

# Path
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/lib:$PATH"

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Zsh plugins
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

# Path sourses
source $ZSH/oh-my-zsh.sh

source $HOME/.aliases
source $HOME/.functions
source $HOME/.joyjet

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

# Zsh plugins
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Zoxide
eval "$(zoxide init zsh)"

# Starship
eval "$(starship init zsh)"

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

# Console Ninja
PATH=$HOME/.console-ninja/.bin:$PATH

# Fnm
export PATH="$HOME/.fnm:$PATH"
eval "$(fnm env --use-on-cd --version-file-strategy=recursive --log-level=quiet)"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/adeonir/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)" || true
