#!/bin/sh

GREAT_LIST=$HOME/Shares/gfwlist.action
GREAT_CONFIG=$HOME/Shares/private/shadowsocks/config.json

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

function grab_bridge_config {
    echo "Grabing bridge config file..."
    echo -n "Tell me the host of this git repo..."
    read anwser

    mkdir $HOME/Shares
    cd $HOME/Shares
    git clone https://$anwser.org/darkgeek/private
}

function grab_great_list {
    echo "Grabing great list..."
    mkdir $HOME/Shares
    cd $HOME/Shares
    echo -n "Tell me where can I find that, base url is enough, I'll launch w3m: "
    read anwser

    w3m $anwser
}

function add_actions_file {
    echo "Adding actions file..."
    echo "actionsfile gfwlist.action" | sudo tee -a $1
}

function move_action_file {
    echo "Moving action file..."
    sudo mv $GREAT_LIST $1
}

function copy_bridge_config {
    echo "Moving bridge config..."
    sudo cp $GREAT_CONFIG $1
}
