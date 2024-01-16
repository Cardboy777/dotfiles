#!/usr/bin/env fish

alias npm=pnpm

alias ls=exa

alias firefox=brave

alias vim=nvim

alias htop=btop

if [ "$XDG_SESSION_DESKTOP" = "KDE" ]
    alias restart-plasma="~/Scripts/bash/restart-plasma.sh"
    alias plasma-restart="restart-plasma"
end

function shortcut --description "Create a shortcut to a file or directory" -a to from
    if test (count $argv) -ne 2
        echo "Usage: shortcut to from"
        return 1
    end
    if not test -e "$to"
        echo "Target '$to' does not exist"
        return 1
    end
    ln -s -T "$to" "$from"
    return 0
end
