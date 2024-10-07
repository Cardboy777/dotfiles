#!/bin/bash

function getRandomFile() {
    local dir=$1
    find "$dir" -maxdepth 1 | sort -R | tail -n 1
}

Dir1080pH="$HOME/Pictures/Wallpapers/_Active/1080p"
Dir1080pV="$HOME/Pictures/Wallpapers/_Active/1080p-Vertical"
Dir1440p="$HOME/Pictures/Wallpapers/_Active/1440p"

monitor1440p="DP-1"      # Samsung
monitor1080pH="DP-3"     # HP
monitor1080pV="HDMI-A-1" # Asus

image1440p=$(getRandomFile "$Dir1440p")
image1080pH=$(getRandomFile "$Dir1080pH")
image1080pV=$(getRandomFile "$Dir1080pV")

function setSwww() {
    swww img -o $monitor1440p -t wave --transition-angle 70 --transition-wave 12,12 "$image1440p"
    swww img -o $monitor1080pH -t wave --transition-angle 70 --transition-wave 12,12 "$image1080pH"
    swww img -o $monitor1080pV -t wave --transition-angle 70 --transition-wave 12,12 "$image1080pV"
}

setSwww

function setHyprpaper() {
    hyprctl hyprpaper unload all

    hyprctl hyprpaper preload "$image1440p"
    hyprctl hyprpaper preload "$image1080pH"
    hyprctl hyprpaper preload "$image1080pV"

    hyprctl hyprpaper wallpaper "$monitor1440p,$image1440p"
    hyprctl hyprpaper wallpaper "$monitor1080pH,$image1080pH"
    hyprctl hyprpaper wallpaper "$monitor1080pV,$image1080pV"
}

# setHyprpaper
