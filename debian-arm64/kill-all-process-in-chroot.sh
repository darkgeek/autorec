#!/bin/sh
# Obtained from https://askubuntu.com/a/552038

CHROOT="$1"

#Find processes who's root folder is actually the chroot
for ROOT in $(find /proc/*/root)
do
        #Check where the symlink is pointing to
        LINK=$(readlink -f $ROOT)

        #If it's pointing to the $CHROOT you set above, kill the process
        if echo $LINK | grep -q ${CHROOT%/}
        then
                PID=$(basename $(dirname "$ROOT"))
                echo Kill $PID in chroot
                #kill -9 $PID
        fi
done
