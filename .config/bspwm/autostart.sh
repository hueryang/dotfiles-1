#!/usr/bin/env bash

command -v dunstk &> /dev/null &&  dunst --config $HOME/.config/dunst/dunstrc &
command -v picom &> /dev/null && picom --config $HOME/.config/picom/picom.conf &
command -v xautolock &> /dev/null && xautolock -time 10 -locker "i3lock -c 000000" &

# set background
feh --bg-fill ~/Pictures/dracula-gentoo.png  

# launch sxhkd
pgrep -x sxhkd > /dev/null || sxhkd &

# launch polybar
$HOME/.config/polybar/launch.sh &

if [ -x "$(command -v fcitx5)" ]; then
    echo 'use fcitx5'
    export GTK_IM_MODULE=fcitx5
    export QT_IM_MODULE=fcitx5
    export XMODIFIERS=@im=fcitx5
    fcitx5 &  
elif [ -x "$(command -v fcitx)" ]; then
    echo 'use fcitx'
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    fcitx -dr    
elif [ -x "$(command -v ibus-daemon)" ]; then
    echo 'use ibus'
    export GTK_IM_MODULE=ibus
    export QT_IM_MODULE=ibus
    export XMODIFIERS=@im=ibus
    ibus-daemon -drx
fi



