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
        mkdir $WORKSPACE_DIR/tmp
        mkdir -p $WORKSPACE_DIR/tools/bin
    fi
}

function install_package() {
    if exists "apt-get"; then
        sudo apt-get -y install $1
    elif exists "brew"; then
        brew install $1
    elif exists "pacman"; then
        sudo pacman -Syu $1
    fi
}

function install_if_not_exists() {
    if exists $1; then
        echo "$1 is already installed"
    else
        install_package $1
    fi
}

function install_peco() {
    local FILENAME=$1
    echo 'get newest peco'"'"'s release file url'
    local RELEASE=$(curl -s https://api.github.com/repos/peco/peco/releases | grep 'browser_download_url' | grep $FILENAME | head -n 1 | sed -e 's/^.*"\(https.*\)".*$/\1/')
    echo 'download newest peco archive'
    curl -L $RELEASE > $WORKSPACE_DIR/tmp/peco.tar.gz
    cd $WORKSPACE_DIR/tmp
    echo 'extract peco'
    tar xzvf $WORKSPACE_DIR/tmp/peco.tar.gz
    echo 'install peco'
    mv $WORKSPACE_DIR/tmp/peco_linux_amd64/peco $WORKSPACE_DIR/tools/bin/peco
}

function install_ghq() {
    local FILENAME=$1
    echo 'get newest ghq'"'"'s release file url'
    local RELEASE=$(curl -s https://api.github.com/repos/motemen/ghq/releases | grep 'browser_download_url' | grep $FILENAME | head -n 1 | sed -e 's/^.*"\(https.*\)".*$/\1/')
    echo 'download newest ghq archive'
    curl -L $RELEASE > $WORKSPACE_DIR/tmp/ghq.zip
    cd $WORKSPACE_DIR/tmp
    echo 'extract ghq'
    unzip $WORKSPACE_DIR/tmp/ghq.zip
    echo 'install ghq'
    mv $WORKSPACE_DIR/tmp/ghq $WORKSPACE_DIR/tools/bin/ghq
}

function install_dein() {
    curl -L https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $WORKSPACE_DIR/tmp/installer.sh
    cd $WORKSPACE_DIR/tmp
    sh ./installer.sh ~/.cache/dein
}

function install_nvm() {
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
}

# create workspace directory
create_workspace

echo "package install phase"
install_if_not_exists "zsh"
install_if_not_exists "tmux"
install_if_not_exists "vim"
install_if_not_exists "git"
install_if_not_exists "curl"
install_peco 'peco_linux_amd64.tar.gz'
install_ghq 'ghq_linux_amd64.zip'
install_dein
install_nvm
# wget -qO - https://github.com/peco/peco/releases/download/v0.5.1/peco_linux_amd64.tar.gz > $WORKSPACE_DIR/tmp/peco.tar.gz
# cd $WORKSPACE_DIR/tmp
# tar xzvf $WORKSPACE_DIR/tmp/peco.tar.gz
# mv $WORKSPACE_DIR/tmp/peco/peco $WORKSPACE_DIR/tools/bin/peco

# change login shell
chsh -s $(which zsh)

# curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $WORKSPACE_DIR/install_dein.vim.sh
# sh $WORKSPACE_DIR/install_dein.vim.sh $HOME/.vim/dein

git clone https://github.com/remew/dotfiles $WORKSPACE_DIR/dotfiles

if [ -e $HOME/dotfiles ]; then
    rm -rf $HOME/dotfiles
fi

