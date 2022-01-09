#!/bin/bash

CURRENT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
SCRIPT_NAME=`basename "$0"`

. $CURRENT_DIR/../common/libcomm.sh

echo "Recover packages..."
echo "Working dir is $CURRENT_DIR"
mv $HOME/.bashrc $HOME/.bashrc.bk
cd $CURRENT_DIR

# see https://forums.gentoo.org/viewtopic-t-926884-start-0.html
echo Copying world file...
sudo cp ./world /var/lib/portage/world
sudo emerge -DuN world

echo "Recover dotfiles..."
drag_dotfiles
stow_common_dotfiles
stow_dotfile systemd

echo "Add user to groups..."
sudo usermod -a -G sudo,audio,shadow,systemd-journal justin

set_locale
set_timezone
set_hostname

echo "Recover Internet..."
recover_internet
sudo mv /etc/shadowsocks/config.json /etc/shadowsocks-libev/
