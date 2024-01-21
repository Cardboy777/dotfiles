#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: addConfigLink.sh <file>"
    exit 1
fi

target="$HOME/Repositories/dotfiles/config/$1"
destination="$HOME/.config/$1"

if [ ! -e "$target" ]; then
    echo "$target does not exist."
    exit 1
fi

if [ -e "$destination" ]; then
    echo "$destination already exists."
    exit 1
fi

ln -s -T "$target" "$destination"

