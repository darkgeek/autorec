#!/bin/sh

CURRENT_DIR=`dirname "$0"`
SCRIPT_NAME=`basename "$0"`

. $CURRENT_DIR/../common/libarch.sh
. $CURRENT_DIR/../common/libcomm.sh

echo "Working dir is $CURRENT_DIR"

cd $CURRENT_DIR
backup_packages

echo "Backup important config files..."
cp /etc/sysctl.d/sysctl.conf .
cp /boot/config.txt .
cp /etc/systemd/resolved.conf .
cp -r /usr/lib/binfmt.d .
