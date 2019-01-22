#!/bin/bash

CURRENT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
SCRIPT_NAME=`basename "$0"`

. $CURRENT_DIR/../common/libdeb.sh
. $CURRENT_DIR/../common/libcomm.sh

echo "Recover dotfiles..."
drag_dotfiles
stow_common_dotfiles

echo "export PATH=$PATH:$HOME/bin" >> $HOME/.bash_profile

echo "Recover Internet..."
cd $HOME
grab_bridge_config
grab_great_list
move_action_file /etc/privoxy/
add_actions_file /etc/privoxy/config
