#!/bin/bash

CURRENT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
SCRIPT_NAME=`basename "$0"`

. $CURRENT_DIR/../common/libsuse.sh
. $CURRENT_DIR/../common/libcomm.sh

echo "Recover packages..."
echo "Working dir is $CURRENT_DIR"
mv $HOME/.bashrc $HOME/.bashrc.bk
cd $CURRENT_DIR
recover_package_list

echo "Recover dotfiles..."
drag_dotfiles
stow_common_dotfiles

echo "Recover custom scripts..."
mkdir -p $HOME/Apps/bin

echo "Add user to groups..."
sudo usermod -a -G audio,shadow,systemd-journal justin

set_locale
set_timezone
set_hostname
