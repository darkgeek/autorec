#!/bin/sh

CURRENT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
SCRIPT_NAME=`basename "$0"`

. $CURRENT_DIR/../common/libarch.sh
. $CURRENT_DIR/../common/libcomm.sh

#echo "Recover faked bins..."
#cp -r bin $HOME/
#echo "export PATH=$HOME/bin:\$PATH" >> $HOME/.bash_profile
#. $HOME/.bash_profile
#echo "Current PATH is $PATH"

#echo "Patch makepkg..."
#cd $HOME/bin
#cp /usr/bin/makepkg .
#patch < $CURRENT_DIR/makepkg.patch

echo "Recover packages..."
echo "Working dir is $CURRENT_DIR"

echo "Firstly, we add a fast mirror for pacman..."
sed -i '1s/^/Server = https\:\/\/mirrors\.tuna\.tsinghua\.edu\.cn\/archlinuxarm\/\$arch\/\$repo \n/' /etc/pacman.d/mirrorlist
head /etc/pacman.d/mirrorlist

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

echo "Recover toybox..."
$HOME/Apps/bin/aurin toybox
echo "alias top='toybox top'" >> $HOME/.bash_profile
echo "alias ps='toybox ps'" >> $HOME/.bash_profile
echo "alias uptime='toybox uptime'" >> $HOME/.bash_profile

echo "Fix empty user issue..."
sed -i '1s/^/export USER=root \n/' $HOME/.bash_profile

echo "Recover Internet"
recover_internet
