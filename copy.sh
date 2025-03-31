#!/bin/bash

# This is the script I use to specify which dot files I want to
# include in the git repo. This directory does not exist in $HOME.
# I use `.scripts` for miscellaneous scripts that I either run from
# my window manager or from cron jobs.

TO_CREATE=(
  ".config"
  ".local/share/qutebrowser"
  ".scripts"
)

DIRS=(
  ".config/kitty"
  ".config/nvim"
  ".config/qutebrowser"
  ".config/fuzzel"
  ".config/sway"
  ".config/waybar"
  ".local/share/qutebrowser/userscripts"
)

FILES=(
  ".zshrc"
  ".tmux.conf"
  "jonah.zsh-theme"
)

for x in ${TO_CREATE[@]}; do
  rm -r ./${x}
  mkdir -p ./${x}/
done

for d in ${DIRS[@]}; do
  cp -r ~/${d}/ ./${d}
done

for f in ${FILES[@]}; do
  cp ~/${f} ./${f}
done
