#!/bin/sh

# Constants
PKG_LIST=pkglist.txt
AUR_LIST=aur.txt

function backup_packages {
    echo "Generate a list of packages..."
    pacman -Qqen > $PKG_LIST
    pacman -Qqm > $AUR_LIST
}

function recover_packages {
    echo "Recover list of packages..."
    sudo pacman -S --needed - < $PKG_LIST

    echo "Packages from AUR should be installed manually..."
    cat $AUR_LIST
}

function add_pacman_mirror {
    echo "Add fast mirror for pacman..."
    sed -i '1s/^/Server = https\:\/\/mirrors\.tuna\.tsinghua\.edu\.cn\/archlinuxarm\/\$arch\/\$repo \n/' /etc/pacman.d/mirrorlist
    head /etc/pacman.d/mirrorlist
}

function recover_internet {
    grab_bridge_config
    sudo mkdir /etc/shadowsocks
    copy_bridge_config /etc/shadowsocks

    grab_great_list
    move_action_file /etc/privoxy/
    add_actions_file /etc/privoxy/config
}
