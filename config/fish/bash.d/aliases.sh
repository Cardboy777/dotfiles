#!/bin/bash

alias vim=nvim

alias htop=btop

alias ls=eza
alias cat=bat

alias firefox=brave

alias neofetch=fastfetch

alias addLutrisGame='$XDG_CONFIG_HOME/fish/bash.d/scripts/add-lutris-game.sh'
alias tailscaleExitNode='$XDG_CONFIG_HOME/fish/bash.d/scripts/pick-tailscale-exit-node-cli.sh'

# tmux
alias tl='tmux ls'
alias ta='tmux a -t'
alias tk='$XDG_CONFIG_HOME/fish/bash.d/scripts/tmux-kill.sh'
alias ts='$XDG_CONFIG_HOME/fish/bash.d/scripts/tmux-sessionizer.sh'

alias hosts='cat /etc/hosts | grep "192\.168\.1\..*"'
