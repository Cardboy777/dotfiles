#!/bin/bash

alias vim=nvim

alias htop=btop

alias ls=eza
alias cat=bat

alias firefox=brave

alias neofetch=fastfetch

alias hosts=cat /etc/hosts | grep "192\.168\.1\..*"

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
