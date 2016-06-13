#!/bin/bash

# define variables
DEBUG=1
DOTFILES_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
echo "dotfiles directory : ["$DOTFILES_DIR"]"

# define functions
function link_dotfile() {
    target=$HOME/$1
    src=$DOTFILES_DIR/$1
    if [ $DEBUG = 1 ]; then
        echo "ln -s $src $target"
    else
        ln -s $src $target
    fi
}

function exists() {
    which "$1" > /dev/null 2>&1
    return $?
}


# execute to link
link_dotfile ".vimrc"
link_dotfile ".zshrc"
link_dotfile ".tmux.conf"

if exists "apt-get"; then
    echo "package install phase for Ubuntu"
    if exists "zsh"; then
        echo "zsh is already installed"
    else
        sudo apt-get -y install zsh
        echo "zsh path is..."
        which zsh
        chsh
    fi
    if exists "tmux"; then
        echo "tmux is already installed"
    else
        sudo apt-get -y install tmux
    fi
    if exists "vim"; then
        echo "vim is already installed"
    else
        sudo apt-get -y install vim
    fi
fi
