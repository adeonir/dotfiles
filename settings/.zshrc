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
  brew
  node
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

# Starship
eval "$(starship init zsh)"

# Fnm
export PATH="$HOME/.fnm:$PATH"
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

# Console Ninja
PATH=$HOME/.console-ninja/.bin:$PATH

# Joyjet ssh key
function cd() {
  builtin cd "$@"  # Call the original `cd` command

  if [[ "$PWD" == "$HOME/Developer/joyjet"* ]]; then
    ssh-add ~/.ssh/id_rsa_joyjet
  fi
}
