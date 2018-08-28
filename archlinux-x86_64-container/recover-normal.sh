#!/bin/sh

CURRENT_DIR=`dirname "$0"`
SCRIPT_NAME=`basename "$0"`

. $CURRENT_DIR/../common/libcomm.sh

echo "Recover dotfiles..."
drag_dotfiles
stow_common_dotfiles
stow_dotfile archlinux-apps

echo "Setting important environment variables..."
echo "export DISPLAY=:0" >> $HOME/.bash_profile
echo "export PULSE_SERVER=/tmp/pulse.socket" >> $HOME/.bash_profile
