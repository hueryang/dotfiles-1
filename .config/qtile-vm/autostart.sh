#!/usr/bin/env sh
# Set wallpaper

command -v dunst &> /dev/null && dunst --config $HOME/.config/dunst/dunstrc &
command -v picom &> /dev/null && picom --config $HOME/.config/picom/picom.conf &
command -v seafile-applet &> /dev/null && seafile-applet &
command -v flameshot &> /dev/null && flameshot &

# set background
test -e /etc/os-release && os_release='/etc/os-release' || os_release='/usr/lib/os-release'
. "${os_release}"

feh --bg-fill /work/Pictures/wallpapers/dracula/${ID:-linux}.png
