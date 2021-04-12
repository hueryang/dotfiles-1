#!/usr/bin/env bash

monitors=(`xrandr -q | grep " connected" | awk '{print $1}'`)
echo $monitors > ~/log

if [ ${#monitors[@]} -eq 1 ]
then
    echo "monitor number is 1" >> ~/log
    bspc monitor -d 1 2 3 4 5 6 7 8 9 0
elif [ ${#monitors[@]} -eq 2 ]
then
    $HOME/.bin/office-desktop.sh
    echo "monitor number is 2" >> ~/log
    bspc monitor ${monitors[0]} -d 1 2 3 4 5
    bspc monitor ${monitors[1]} -d 6 7 8 9 0
fi

