#!/bin/bash

Link="$1"
LaunchOptions=""
LaunchOptions+=" --really-quiet --fs=no --force-window"
LaunchOptions+=" --volume=80"
LaunchOptions+=" --autofit=25% --geometry=-10-15"
LaunchOptions+=" --x11-name=Picture-in-Picture"
LaunchOptions+=" --script-opts=osc-vidscale=no"
LaunchOptions+=" --ytdl-raw-options=force-ipv4="

LaunchCmd=(/usr/bin/mpv $LaunchOptions "$Link")
"${LaunchCmd[@]}" &
