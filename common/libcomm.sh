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
    mv ~/.bashrc /tmp
    cd $HOME/dotfiles
    ls | xargs stow
}

function stow_common_dotfiles {
    echo "Stow common dotfiles..."
    mv ~/.bashrc /tmp
    cd $HOME/dotfiles
    ls | grep -v systemd | grep -v archlinux-apps | xargs stow
}

function set_locale {
    echo "Setting locale..."
    sudo sed -i 's/^#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
    sudo locale-gen
    echo LANG=en_US.UTF-8 | sudo tee /etc/locale.conf
}

function set_timezone {
    echo "Setting timezone..."
    sudo ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
}

function set_hostname {
    echo -n "Setting hostname...Tell me your hostname: "
    read anwser

    echo $anwser | sudo tee /etc/hostname
    echo "127.0.0.1 $anwser" | sudo tee -a /etc/hosts
}
