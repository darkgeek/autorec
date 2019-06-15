#!/bin/sh

echo fetch sshd pid...
SSHD_PID=`cat /data/local/archlinux/run/sshd.pid`

echo SSHD_PID is $SSHD_PID
kill -9 $SSHD_PID


