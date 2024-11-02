#!/bin/bash

function restartWpaperd() {
    pkill -x wpaperd
    nohup wpaperd -d >/dev/null 2>&1 &
}
function restartHyprpaper() {
    pkill -x hyprpaper
    nohup hyprpaper >/dev/null 2>&1 &
}
function restartSwww() {
    pkill -x swww-daemon
    nohup swww-daemon >/dev/null 2>&1 &
}

function restartWallpaperDaemon() {
    #wpaper is goated and doesn't require anything fancy
    if pgrep -x wpaperd >/dev/null; then
        restartWpaperd
    elif pgrep -x hyprpaper >/dev/null; then
        restartHyprpaper
    elif pgrep -x swww-daemon >/dev/null; then
        restartSwww
    else
        echo "Cannot find wallpaper daemon, starting one..."
        restartSwww
    fi
    return 0
}

restartWallpaperDaemon
