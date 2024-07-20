#!/bin/bash

alias npm=pnpm

alias vim=nvim

alias htop=btop

alias ls=eza

alias firefox=brave

alias neofetch=fastfetch

# tmux
alias tl='tmux ls'
alias ta='tmux a -t'
alias tk='~/.config/fish/bash.d/scripts/tmux-kill.sh'
alias ts='~/.config/fish/bash.d/scripts/tmux-sessionizer.sh'

shortcut() {
    target=$1
    destination=$2
    ln -S -T "$target" "$destination"
}
