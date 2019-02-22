#!/bin/sh

CURRENT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
SCRIPT_NAME=`basename "$0"`

. $CURRENT_DIR/../common/libcomm.sh

function add_actions_file_openbsd {
    echo "Adding actions file..."
    echo "actionsfile gfwlist.action" | doas tee -a $1
}

function move_action_file_openbsd {
    echo "Moving action file..."
    doas mv $GREAT_LIST $1
}


echo "Recover packages..."
echo "Working dir is $CURRENT_DIR"
cd $CURRENT_DIR
doas pkg_add -l ./pkglist.txt

echo "Recover dotfiles..."
drag_dotfiles
stow_dotfile ksh
stow_dotfile bash
stow_dotfile git
stow_dotfile keepassxc
stow_dotfile vim
stow_dotfile fcitx

echo "Recover important configs..."
cd $CURRENT_DIR
doas cp -r /etc/monit.d .
doas cp /etc/monitrc .
doas cp /etc/pf.conf .

doas cp rc.conf.local /etc/
doas cp sysctl.conf /etc/
doas cp doas.conf /etc/
doas cp installurl /etc/
doas cp ntpd.conf /etc/
doas cp mixerctl.conf /etc/
doas cp shadowsocks_go /etc/rc.d/

cp .xsession $HOME/

echo "Configuring basic system setting..."
echo "Setting Locale..."
echo 'export LC_CTYPE="en_US.UTF-8"' >> /home/justin/.profile
echo 'export LC_ALL="en_US.UTF-8"' >> /home/justin/.profile

echo "Setting kshrc..."
echo 'export ENV=$HOME/.kshrc' >> /home/justin/.profile

echo "Recover Internet..."
grab_bridge_config

grab_great_list
move_action_file_openbsd /etc/privoxy/
add_actions_file_openbsd /etc/privoxy/config
