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
    pacman -S - < $PKG_LIST

    echo "Packages from AUR should be installed manually..."
    cat $AUR_LIST
}

