#!/bin/sh

GIT_URL="https://github.com/remew/dotfiles.git"
TAR_URL="https://github.com/remew/dotfiles/archive/master.tar.gz"
DOT_PATH=$HOME/dotfiles

function exists() {
    which "$1" > /dev/null 2>&1
    return $?
}

function dotfiles_download() {
    if exists "git"; then
        git clone $GIT_URL
    elif exists "curl" || exists "wget"; then
        if exists "curl"; then
            curl -L $TAR_URL
        elif exists "wget"; then
            wget -qO - $TAR_URL
        fi | tar zxv
        mv dotfiles-master dotfiles
    else
        echo "curl or wget is required"
        exit 1
    fi
}

echo "==========================="
echo "remew's dotfiles bootloader"
echo "==========================="

dotfiles_download

cd dotfiles
./install.sh

