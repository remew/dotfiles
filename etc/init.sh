#!/bin/bash

# define variables
WORKSPACE_DIR=$HOME/workspace

# define functions
function exists() {
    which "$1" > /dev/null 2>&1
    return $?
}

function create_workspace() {
    if [ -e $WORKSPACE_DIR ]; then
        echo "$WORKSPACE_DIR is already exists."
    else
        mkdir $WORKSPACE_DIR
    fi
}

# create workspace directory
create_workspace

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
        curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $WORKSPACE_DIR/install_dein.sh
        sh ./install_dein.vim.sh $HOME/.vim/dein
    fi
    if exists "git"; then
        echo "git is already installed"
    else
        sudo apt-get -y install git
    fi
fi
