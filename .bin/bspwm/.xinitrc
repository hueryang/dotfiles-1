#!/bin/sh

userresources=$HOME/.config/X11/xresources
usermodmap=$HOME/.config/X11/xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

if [ -x "$(command -v ibus-daemon)" ]; then
    echo 'use ibus'
    export GTK_IM_MODULE=xim
    export QT_IM_MODULE=xim
    export XMODIFIERS=@im=ibus
    ibus-daemon -drx
fi

$HOME/.bin/office-desktop.sh
hsetroot -solid "#000000"

export XDG_CURRENT_DESKTOP=BSPWM



exec dbus-launch --exit-with-session bspwm 
