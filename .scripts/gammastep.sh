#!/bin/bash

if [ -z $(pgrep -x "gammastep") ] && [ -n $(pgrep -x "sway") ]
then
  gammastep -l 38.80:-90.76 -t 6500:4000
	echo "Flu.x started up"
else
	echo "Flu.x is either already running, or sway is not"
fi
