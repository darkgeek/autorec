#!/bin/sh

CURRENT_DIR=`dirname "$0"`
SCRIPT_NAME=`basename "$0"`

. $CURRENT_DIR/../common/libarch.sh
. $CURRENT_DIR/../common/libcomm.sh

echo "Working dir is $CURRENT_DIR"

cd $CURRENT_DIR

echo "Backing up packages..."
pkg_info -mz | tee pkglist.txt

echo "Backing up important config files..."
doas cp -r /etc/monit.d .
doas cp /etc/monitrc .
doas cp /etc/pf.conf .

cp /etc/rc.conf.local .
cp /etc/sysctl.conf .
cp /etc/doas.conf .
cp /etc/installurl .
cp /etc/ntpd.conf .
cp /etc/mixerctl.conf .
cp $HOME/.xsession .
cp /etc/rc.d/shadowsocks_go .
cp /etc/login.conf .

doas chown -R justin .
