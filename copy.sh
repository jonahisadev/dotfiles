#!/bin/bash

# This is the script I use to specify which dot files I want to
# include in the git repo. This directory does not exist in $HOME.
# I use `scripts` for miscellaneous scripts that I either run from
# my window manager or from cron jobs.

TO_CREATE=(
  ".config"
  ".local/share"
  ".local/share/qutebrowser"
  "scripts"
)

DIRS=(
  ".config/alacritty"
  ".config/i3"
  ".config/dunst"
  ".config/nvim"
  ".config/picom"
  ".config/polybar"
  ".config/qutebrowser"
  ".config/rofi"
  ".local/share/qutebrowser/userscripts"
)

FILES=(
  "scripts/hide_cursor.sh"
  "scripts/qutempv.sh"
  "scripts/redshift.sh"
  "scripts/update.sh"
  "scripts/updater.sh"
  "scripts/update_count.sh"
  ".config/starship.toml"
  ".zshrc"
  ".tmux.conf"
)

for x in ${TO_CREATE[@]}; do
  mkdir -p ./${x}/
done

for d in ${DIRS[@]}; do
  cp -r ~/${d}/ ./${d}
done

for f in ${FILES[@]}; do
  cp ~/${f} ./${f}
done
