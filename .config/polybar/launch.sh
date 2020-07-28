#!/usr/bin/env bash

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
monitors=(`xrandr -q | grep " connected" | awk '{print $1}'`)

for i in "${!monitors[@]}" ; do
    MONITOR=${monitors[$i]} polybar -c ~/.config/polybar/config $i &
done
