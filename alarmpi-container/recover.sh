#!/bin/sh

CURRENT_DIR=`dirname "$0"`
SCRIPT_NAME=`basename "$0"`

. $CURRENT_DIR/../common/libarch.sh
. $CURRENT_DIR/../common/libcomm.sh

echo "Recover packages..."
echo "Working dir is $CURRENT_DIR"
add_pacman_mirror
cd $CURRENT_DIR
recover_packages

echo "Recover dotfiles..."
drag_dotfiles
stow_common_dotfiles
stow_dotfile archlinux-apps

echo "Configuring basic system setting..."
set_locale
set_timezone
set_hostname

echo "Setting important environment variables..."
echo "export DISPLAY=:0" >> $HOME/.bash_profile
echo "export PULSE_SERVER=/tmp/pulse.socket" >> $HOME/.bash_profile

echo "Recover Internet..."
recover_internet
