#!/bin/sh

PREFIX=/data/local/archlinux
PRE_CMD='hostname darkgeek-alarm-kars'
DEFAULT_CMD=bash
CMD=$@

if [ -z "$CMD" ]
then
    CMD=$DEFAULT_CMD
fi
echo CMD is $CMD

mount | grep 'on /data' | grep nosuid
IS_NOSUID_ENABLED=$?
if [ $IS_NOSUID_ENABLED -eq 0 ]
then
    echo remount /data as suid enabled...
    mount -o remount,suid /data
fi

echo mount resources...
mount --rbind /dev $PREFIX/dev
mount --rbind /dev/pts $PREFIX/dev/pts
mount --rbind /sys $PREFIX/sys
mount --rbind /proc $PREFIX/proc
mount -t tmpfs tmpfs $PREFIX/tmp

echo start shell...
export HOME=/root
chroot /data/local/archlinux sh -c "cd $HOME ; $PRE_CMD ; $CMD"

echo kill all processes in chroot...
for ROOT in /proc/*/root; do
    LINK=$(readlink $ROOT)
    if [ "x$LINK" != "x" ]; then
        if [ "x${LINK:0:${#PREFIX}}" = "x$PREFIX" ]; then
            # this process is in the chroot...
            PID=$(basename $(dirname "$ROOT"))

            echo Found $PID in chroot, kill it
            kill -9 "$PID"
        fi
    fi
done

echo cleaning...
umount /data/local/archlinux/dev/pts
umount /data/local/archlinux/dev
umount /data/local/archlinux/sys
umount /data/local/archlinux/proc
umount /data/local/archlinux/tmp

