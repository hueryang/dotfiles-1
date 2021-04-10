#/usr/bin/env bash
mychroot=gentoo
umount -f /mnt/$mychroot/dev > /dev/null &
umount -f /mnt/$mychroot/proc > /dev/null &
umount -f /mnt/$mychroot/sys > /dev/null &
umount -f /mnt/$mychroot/tmp > /dev/null &
