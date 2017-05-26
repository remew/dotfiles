#!/bin/bash

# define variables
# DOTFILES_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
WORKSPACE_DIR=$HOME/workspace
DOTFILES_DIR=$WORKSPACE_DIR/dotfiles
echo "dotfiles directory : ["$DOTFILES_DIR"]"

# define functions
function link_dotfile() {
    target=$HOME/$1
    src=$DOTFILES_DIR/$1
    echo "ln -s $src $target"
    ln -s $src $target
}

# execute to link
link_dotfile ".vim" # this is not dotfile. this is directory.
link_dotfile ".vimrc"
link_dotfile ".zshrc"
link_dotfile ".tmux.conf"
link_dotfile ".gitconfig"

