#!/usr/bin/env bash
mychroot=gentoo
mount -o rbind /dev /mnt/$mychroot/dev > /dev/null &
mount -t proc none /mnt/$mychroot/proc > /dev/null &
mount -o bind /sys /mnt/$mychroot/sys > /dev/null &
mount -o bind /tmp /mnt/$mychroot/tmp > /dev/null &
