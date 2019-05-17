#!/bin/sh

PKG_LIST=pkglist.txt

function backup_package_list {
    echo "Generate installed package list..."
    dpkg --get-selections | cut -f1 > $PKG_LIST
}

function recover_package_list {
    echo "Recover packages..."
    xargs -0 apt install -y < <(tr \\n \\0 < $PKG_LIST)
}

function recover_internet {
    grab_bridge_config
    sudo mkdir /etc/shadowsocks
    copy_bridge_config /etc/shadowsocks

    grab_great_list
    move_action_file /etc/privoxy/
    add_actions_file /etc/privoxy/config
}

