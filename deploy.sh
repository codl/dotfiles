#!/bin/bash
DIR=$(dirname "$0")
cd $DIR

find . -type f \! -name deploy.sh \! -name README.markdown \! -path './.git/*' | while read f
do
    newf="$HOME/$f"
    mkdir -p "$(dirname "$newf")"
    if [[ ! -h "$newf" ]]
    then
        rm -f "$newf"
        ln -s "$PWD/$f" "$newf"
        printf "Installed %s to %s\n" "$f" "$newf"
    fi
done
