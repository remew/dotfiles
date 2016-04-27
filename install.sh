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

# execute to link
link_dotfile ".vimrc"
link_dotfile ".zshrc"
link_dotfile ".tmux.conf"

