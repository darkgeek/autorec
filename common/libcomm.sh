#!/bin/sh

function drag_dotfiles {
    cd $HOME
    git clone https://github.com/darkgeek/dotfiles
}

function stow_dotfile {
    echo "Stow $1 dotfile..."
    cd $HOME/dotfiles
    stow $1
}

function stow_all_dotfiles {
    echo "Stow all the dotfiles..."
    cd $HOME/dotfiles
    ls | xargs stow
}

function stow_common_dotfiles {
    echo "Stow common dotfiles..."
    cd $HOME/dotfiles
    ls | grep -v systemd | grep -v archlinux-apps | xargs stow
}
