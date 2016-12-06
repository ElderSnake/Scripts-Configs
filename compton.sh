#!/bin/bash

## Script to toggle the Compton compositor ##

query=$(pidof compton)

if [ ! "$query" ]; then

    ## Start Compton ##
#    compton --backend glx --paint-on-overlay --unredir-if-possible --vsync opengl-swc 
    compton --config ~/.compton.conf -b
    notify-send "Compositing Enabled"

else
    killall compton
    notify-send "Compositing Disabled"
fi

exit 0
