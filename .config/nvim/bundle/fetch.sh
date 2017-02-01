#!/bin/bash

plugins=(
    "css-color#git://github.com/ap/vim-css-color.git"
    "ctrlp#git://github.com/kien/ctrlp.vim.git"
    "dispatch#git://github.com/tpope/vim-dispatch.git"
    "dispatch-neovim#https://github.com/radenling/vim-dispatch-neovim.git"
    "fugitive#git://github.com/tpope/vim-fugitive.git"
    "gitgutter#git://github.com/airblade/vim-gitgutter.git"
    "gitv#git://github.com/gregsexton/gitv.git"
    "jellybeans#git://github.com/nanotech/jellybeans.vim.git"
    "lastplace#git://github.com/dietsche/vim-lastplace.git"
    "mustache-handlebars#git://github.com/mustache/vim-mustache-handlebars.git"
    "obsession#git://github.com/tpope/vim-obsession.git"
    "pathogen#git://github.com/tpope/vim-pathogen.git"
    "sleuth#git://github.com/tpope/vim-sleuth.git"
    "syntastic#git://github.com/scrooloose/syntastic.git"
    "tabular#git://github.com/godlygeek/tabular.git"
    "vimproc#git://github.com/Shougo/vimproc.vim.git"
    "vimshell#git://github.com/Shougo/vimshell.vim.git"
    "vinegar#git://github.com/tpope/vim-vinegar.git"
    "pico8-syntax#https://github.com/codl/vim-pico8-syntax.git"
)


for plugin in ${plugins[*]}; do
    IFS='#' read -ra plugin <<< "$plugin"
    name=${plugin[0]}
    repository=${plugin[1]}
    subdir=${plugin[2]}

    cd ~/.config/nvim/bundle/

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
        cd ~/.config/nvim/bundle/
        rsync -a /tmp/$name/$subdir/ $name
    fi
done

nvim "+Helptags" "+q"
