#!/data/data/com.termux/files/usr/bin/bash

CURRENT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
SCRIPT_NAME=`basename "$0"`

. $CURRENT_DIR/../common/libdeb.sh
. $CURRENT_DIR/../common/libcomm.sh

function termux_add_actions_file {
    echo "Adding actions file..."
    echo "actionsfile gfwlist.action" >> $1
}

function termux_move_action_file {
    echo "Moving action file..."
    mv $GREAT_LIST $1
}

#echo "Use fastest mirror..."
#sed -i 's/deb/#deb/' /data/data/com.termux/files/usr/etc/apt/sources.list
#echo "deb https://mirrors.tuna.tsinghua.edu.cn/termux stable main" >> /data/data/com.termux/files/usr/etc/apt/sources.list
#pkg up

echo "Recover packages..."
echo "Working dir is $CURRENT_DIR"
mv $HOME/.bashrc $HOME/.bashrc.bk
cd $CURRENT_DIR
recover_package_list

echo "Recover dotfiles..."
drag_dotfiles
stow_common_dotfiles

echo "Grabing toybox..."
mkdir $HOME/bin
wget -c http://landley.net/toybox/bin/toybox-aarch64 -O $HOME/bin/toybox
chmod +x $HOME/bin/toybox
echo "alias top='toybox top'" >> $HOME/.bash_profile
echo "alias uptime='toybox uptime'" >> $HOME/.bash_profile
echo "alias ps='toybox ps'" >> $HOME/.bash_profile
echo "export PATH=$PATH:$HOME/bin" >> $HOME/.bash_profile

echo "Recover other config files..."
cp $CURRENT_DIR/rc $HOME/bin/
cp $CURRENT_DIR/termux-url-opener $HOME/bin/
cp $CURRENT_DIR/termux-file-editor $HOME/bin/
cp $CURRENT_DIR/bad-apps-detect-wrapper.sh $HOME/bin/
cp $CURRENT_DIR/bad-apps-detect.sh $HOME/bin/
cp $CURRENT_DIR/.mpdconf $HOME/
mkdir $HOME/Music
ln -s /sdcard/netease/cloudmusic/Music $HOME/Music/
ln -s /sdcard/Movies $HOME/Music

echo "You could just start syncthing to init your keepass before continue, press any key to continue"
read noop

echo "Recover Internet..."
grab_bridge_config
grab_great_list
termux_move_action_file $HOME/../usr/etc/privoxy/
termux_add_actions_file $HOME/../usr/etc/privoxy/config
