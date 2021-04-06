#!/usr/bin/env bash

command -v dunstk &> /dev/null &&  dunst --config $HOME/.config/dunst/dunstrc &
command -v picom &> /dev/null && picom --config $HOME/.config/picom/picom.conf &
command -v xautolock &> /dev/null && xautolock -time 10 -locker "i3lock -c 000000" &

pgrep -x sxhkd > /dev/null || sxhkd &

$HOME/.config/polybar/launch.sh &




