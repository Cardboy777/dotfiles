#!/bin/bash

alias npm=pnpm

alias vim=nvim

alias htop=btop

alias ls=eza

alias firefox=brave

# tmux
alias tl='tmux ls'
alias ta='tmux a -t'
alias tk='tmux kill-session -t'
alias ts='bash ~/.config/fish/bash.d/tmux-sessionizer.sh'

shortcut() {
    target=$1
    destination=$2
    ln -S -T "$target" "$destination"
}

