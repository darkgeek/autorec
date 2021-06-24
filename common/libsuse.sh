#!/bin/sh

PKG_LIST=pkglist.txt

function recover_package_list {
    echo "Recover packages..."
    command -v sudo > /dev/null
    IS_SUDO_AVAILABLE=$?
    if [ $IS_SUDO_AVAILABLE -eq 0 ]
    then
        sudo zypper install $(cat $PKG_LIST)
    else
        zypper install $(cat $PKG_LIST)
    fi
}

function recover_internet {
    grab_bridge_config
    sudo mkdir /etc/shadowsocks
    copy_bridge_config /etc/shadowsocks

    grab_great_list
    move_action_file /etc/privoxy/
    add_actions_file /etc/privoxy/config
}

