#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Spotify

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

# Theme Elements
current=$(nowpl get --json)
status=$(printf '%s\n' "$current" | jq 'has("artist")')
if [ "$status" = "true" ]; then
	prompt="`nowpl get --json | jq -r '.title'`"
	mesg="`nowpl get --json | jq -r '.title'` :: `nowpl get --json | jq -r '.artist'`"
else
	prompt='Offline'
	mesg="Spotify is offline"
fi

if [[ ( "$theme" == *'type-1'* ) || ( "$theme" == *'type-3'* ) || ( "$theme" == *'type-5'* ) ]]; then
	list_col='1'
	list_row='6'
elif [[ ( "$theme" == *'type-2'* ) || ( "$theme" == *'type-4'* ) ]]; then
	list_col='6'
	list_row='1'
fi

# Options
layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
playing=$(printf '%s\n' "$current" | jq '.isPlaying')
if [[ "$layout" == 'NO' ]]; then
	if [[ ${playing} == "true" ]]; then
		option_1=" Pause"
	else
		option_1=" Play"
	fi
	option_2=" Stop"
	option_3=" Previous"
	option_4=" Next"
	option_5=" Repeat"
	option_6=" Random"
else
	if [[ ${playing} == "true" ]]; then
		option_1=""
	else
		option_1=""
	fi
	option_2=""
	option_3=""
	option_4=""
	option_5=""
	option_6=""
fi

# Toggle Actions
active=''
urgent=''

# Repeat
repeat=$(printf '%s\n' "$current" | jq '.repeat != false')
if [[ ${repeat} == "true" ]]; then
    active="-a 4"
elif [[ ${repeat} == "false" ]]; then
#    urgent="-u 4"
	:
else
    option_5=" Parsing Error"
fi

# Shuffle
shuffle=$(printf '%s\n' "$current" | jq '.shuffle')
if [[ ${shuffle} == "true" ]]; then
    [ -n "$active" ] && active+=",5" || active="-a 5"
elif [[ ${shuffle} == "false" || ${shuffle} == "null" ]]; then
#    [ -n "$urgent" ] && urgent+=",5" || urgent="-u 5"
	:
else
    option_6=" Parsing Error"
fi

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		${active} ${urgent} \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6" | rofi_cmd
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
#		mpc -q toggle && notify-send -u low -t 1000 " `mpc current`"
		nowpl playback --toggle && notify-send -u low -t 3000 -a "nowpl" " `nowpl get --pretty`"
	elif [[ "$1" == '--opt2' ]]; then
#		mpc -q stop
		nowpl playback --pause
	elif [[ "$1" == '--opt3' ]]; then
#		mpc -q prev && notify-send -u low -t 1000 " `mpc current`"
		nowpl skip --previous && notify-send -u low -t 3000 -a "nowpl" " `nowpl get --pretty`"
	elif [[ "$1" == '--opt4' ]]; then
#		mpc -q next && notify-send -u low -t 1000 " `mpc current`"
		nowpl skip --next && notify-send -u low -t 3000 -a "nowpl" " `nowpl get --pretty`"
	elif [[ "$1" == '--opt5' ]]; then
#		mpc -q repeat
		:
	elif [[ "$1" == '--opt6' ]]; then
#		mpc -q random
		:
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
    $option_3)
		run_cmd --opt3
        ;;
    $option_4)
		run_cmd --opt4
        ;;
    $option_5)
		run_cmd --opt5
        ;;
    $option_6)
		run_cmd --opt6
        ;;
esac
