#!/bin/bash

if [ -z $(pgrep -x "redshift") ] && [ -n $(pgrep -x "i3") ]
then
  redshift -l 38.80:-90.76
	echo "Flu.x started up"
else
	echo "Flu.x is either already running, or i3wm is not"
fi
