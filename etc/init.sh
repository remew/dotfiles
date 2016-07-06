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

function install_if_not_exists() {
    if exists $1; then
        echo "$1 is already installed"
    else
        sudo apt-get -y install $1
    fi
}

# create workspace directory
create_workspace

if exists "apt-get"; then
    echo "package install phase for Ubuntu"
    install_if_not_exists "zsh"
    install_if_not_exists "tmux"
    install_if_not_exists "vim"
    install_if_not_exists "git"
fi

# change login shell
chsh -s $(which zsh)

git clone https://github.com/remew/dotfiles $WORKSPACE_DIR/dotfiles

