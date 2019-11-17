#!/bin/bash

CURRENT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
SCRIPT_NAME=`basename "$0"`

. $CURRENT_DIR/../common/libdeb.sh
. $CURRENT_DIR/../common/libcomm.sh

echo "Recover packages..."
echo "Working dir is $CURRENT_DIR"
mv $HOME/.bashrc $HOME/.bashrc.bk
cd $CURRENT_DIR
recover_package_list

echo "Recover dotfiles..."
drag_dotfiles
stow_common_dotfiles
stow_dotfile systemd

echo "Add user to groups..."
sudo usermod -a -G sudo,audio,shadow,systemd-journal justin

set_locale
set_timezone
set_hostname

echo "Adjust locale for Debian..."
sudo update-locale LC_ALL=en_US.UTF-8

echo "Recover Internet..."
recover_internet
sudo mv /etc/shadowsocks/config.json /etc/shadowsocks-libev/
