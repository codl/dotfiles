#!/bin/bash

plugins=(
    "airline#git://github.com/bling/vim-airline.git"
    "ctrlp#git://github.com/kien/ctrlp.vim.git"
    "dispatch#git://github.com/tpope/vim-dispatch.git"
    "fugitive#git://github.com/tpope/vim-fugitive.git"
    "gitgutter#git://github.com/airblade/vim-gitgutter.git"
    "gitv#git://github.com/gregsexton/gitv.git"
    "obsession#git://github.com/tpope/vim-obsession.git"
    "sleuth#git://github.com/tpope/vim-sleuth.git"
    "syntastic#git://github.com/scrooloose/syntastic.git"
    "vinegar#git://github.com/tpope/vim-vinegar.git"
)


for plugin in ${plugins[*]}; do
    name=${plugin%%#*}
    repository=${plugin#*#}

    cd ~/.vim/bundle/

    echo
    echo "Fetching $name"

    if [[ -d $name ]]; then
        cd $name
        git pull
    else
        git clone $repository $name
    fi
done
