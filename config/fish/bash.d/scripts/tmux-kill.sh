#!/bin/bash
session=$1
if [ -z "$session" ]; then
    echo "No session specified"
    echo "Kill Tmux Server?"
    select yn in "Yes" "No"; do
        case $yn in
        Yes)
            tmux kill-server
            break
            ;;
        No)
            break
            ;;
        esac
    done
    exit 0
fi

tmux kill-session -t "$session"
