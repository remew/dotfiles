#!/bin/bash

# define variables
DOTFILES_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
echo "dotfiles directory : ["$DOTFILES_DIR"]"

# define functions
function link_dotfile() {
    target=$HOME/$1
    src=$DOTFILES_DIR/$1
    echo "ln -s $src $target"
    ln -s $src $target
}

function exists() {
    which "$1" > /dev/null 2>&1
    return $?
}

# execute to link
link_dotfile ".vimrc"
link_dotfile ".zshrc"
link_dotfile ".tmux.conf"

