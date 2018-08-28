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
