#!/data/data/com.termux/files/usr/bin/bash

CURRENT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
SCRIPT_NAME=`basename "$0"`

. $CURRENT_DIR/../common/libdeb.sh
. $CURRENT_DIR/../common/libcomm.sh

echo "Recover packages..."
echo "Working dir is $CURRENT_DIR"
cd $CURRENT_DIR
recover_package_list

echo "Recover dotfiles..."
drag_dotfiles
stow_common_dotfiles

echo "Grabing toybox..."
mkdir $HOME/bin
wget -c http://landley.net/toybox/bin/toybox-armv7l -C $HOME/bin/ -O toybox
echo "alias top='toybox top'" >> $HOME/.bash_profile
echo "alias uptime='toybox uptime'" >> $HOME/.bash_profile
echo "alias ps='toybox ps'" >> $HOME/.bash_profile
echo "export PATH=$PATH:$HOME/bin" >> $HOME/.bash_profile

echo "Recover rc file..."
cp $CURRENT_DIR/rc $HOME/bin/

echo "Recover Internet..."
echo -n "Tell me the path: "
read anwser
cd $HOME
http_proxy=$anwser https_proxy=$anwser go get github.com/shadowsocks/shadowsocks-go/cmd/shadowsocks-local
