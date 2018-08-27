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
    find . -maxdepth 1 -type d ! -name ".git" ! -name "." -exec stow {} \;
}

function stow_common_dotfiles {
    echo "Stow common dotfiles..."
    cd $HOME/dotfiles
    find . -maxdepth 1 -type d ! -name ".git" ! -name "." ! -name "systemd" ! -name "archlinux-apps" -exec stow {} \;
}
