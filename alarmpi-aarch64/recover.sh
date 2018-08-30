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
stow_dotfile systemd

echo "Recover important configs..."
cd $CURRENT_DIR
sudo cp sysctl.conf /etc/sysctl.d/
sudo cp config.txt /boot/
sudo cp resolved.conf /etc/systemd/
sudo cp -r binfmt.d /usr/lib/
echo "load-module module-simple-protocol-tcp source=0 record=true port=12345" | sudo tee -a /etc/pulse/default.pa
echo "load-module module-native-protocol-unix socket=/tmp/pulse.socket" | sudo tee -a /etc/pulse/default.pa

echo "Configuring basic system setting..."
set_locale
set_timezone
set_hostname

echo "Recover Internet..."
recover_internet
