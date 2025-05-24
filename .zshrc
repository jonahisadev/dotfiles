# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:/usr/local/bin:$HOME/go/bin:$HOME/.cargo/bin:/home/jonah/.local/share/gem/ruby/3.0.0/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Env variables I like
export MANPAGER="nvim +Man! --cmd 'let g:loaded_persisted=1'"

# Neovim!!
export EDITOR=nvim

# Dynamic libs from local lib
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH":/usr/local/lib

# Screenshot directory
export XDG_SCREENSHOTS_DIR="$HOME/Pictures/screenshots"

# Titles
export DISABLE_AUTO_TITLE="true"
function set_terminal_title() {
  echo -en "zsh"
}

# Theme
ZSH_THEME="jonah" # set by `omz`

# Plugins
plugins=(
  git
  vi-mode
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Keybindings
# bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

# oh my zsh
source $ZSH/oh-my-zsh.sh

# Replace ls with exa
if [ "$(command -v exa)" ]; then
    unalias -m 'la'
    unalias -m 'ls'
    unalias -m 'la'
    unalias -m 'l'
    alias ls='exa -G --color auto --icons -s type'
    alias l='exa -l --color auto --icons -s type'
    alias ll='exa -G --color auto --icons -a -s type'
    alias la='exa -l --color always --icons -a -g -s type'
fi

# Replace cat with bat
if [ "$(command -v bat)" ]; then
    unalias -m 'cat'
    alias cat='bat -pp --theme="Catppuccin-mocha"'
fi 

# Deno
export DENO_INSTALL="/home/jonah/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# ASDF version manager
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
source ~/.rvm/scripts/rvm

# GPG
GPG_TTY=$(tty)
export GPG_TTY

# Turso
export PATH="$PATH:/home/jonah/.turso"

# PWD
export PATH="$PATH:/home/jonah/Dev/pwd/.build"

# P42
export P42_LIB="/usr/local/lib/libykcs11.so"
