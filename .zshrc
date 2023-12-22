# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:/usr/local/bin:$HOME/go/bin:$HOME/.cargo/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Env variables I like
export MANPAGER="nvim +Man! --cmd 'let g:loaded_persisted=1'"

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
    alias cat='bat -pp --theme="gruvbox-dark"'
fi 

# Deno
export DENO_INSTALL="/home/jonah/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# ASDF version manager
. /opt/asdf-vm/asdf.sh
