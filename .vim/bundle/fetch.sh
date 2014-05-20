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
    "tabular#git://github.com/godlygeek/tabular.git"
    "vinegar#git://github.com/tpope/vim-vinegar.git"
    "vimproc#git://github.com/Shougo/vimproc.vim.git"
    "vimshell#git://github.com/Shougo/vimshell.vim.git"
    "pathogen#git://github.com/tpope/vim-pathogen.git"
    "jellybeans#git@github.com:nanotech/jellybeans.vim.git"
)


for plugin in ${plugins[*]}; do
    IFS='#' read -ra plugin <<< "$plugin"
    name=${plugin[0]}
    repository=${plugin[1]}
    subdir=${plugin[2]}

    cd ~/.vim/bundle/

    echo
    echo "Fetching $name"

    if [[ -n $subdir ]]; then
        cd /tmp
    fi

    if [[ -d $name ]]; then
        cd $name
        git pull
    else
        git clone $repository $name
    fi

    if [[ -f $name/Makefile ]]; then
        cd $name
        make
    fi

    if [[ -n $subdir ]]; then
        cd ~/.vim/bundle/
        rsync -a /tmp/$name/$subdir/ $name
    fi
done

vim "+Helptags" "+q"
