#!/bin/bash

alias npm=pnpm

alias vim=nvim

if [ "$XDG_SESSION_DESKTOP" == "KDE" ]
then
    alias restart-plasma="~/Scripts/bash/restart-plasma.sh"
    alias plasma-restart="restart-plasma"
fi

shortcut() {
    target=$1
    destination=$2
    ln -S -T "$target" "$destination"
}
