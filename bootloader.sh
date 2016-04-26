#!/bin/sh

GIT_URL="https://github.com/remew/dotfiles.git"
TAR_URL="https://github.com/remew/dotfiles/archive/master.tar.gz"
DOT_PATH=~/dotfiles

function is_exists() {
    which "$1" > /dev/null 2>&1
    return $?
}

echo "==========================="
echo "remew's dotfiles bootloader"
echo "==========================="


