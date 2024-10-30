#!/bin/bash

WallpaperRootDir="$HOME/Pictures/Wallpapers/_Active"

function getRandomFile() {
    local dir=$1
    find "$dir" -maxdepth 1 | sort -R | tail -n 1
}

function setSwww() {
    local monitor=$1
    local image=$2
    swww img -o "$monitor" --resize fit -t random --transition-duration 1 --transition-fps 144 --transition-angle 70 --transition-wave 12,12 "$image" &
}

function setHyprpaper() {
    local monitor=$1
    local image=$2

    hyprctl hyprpaper preload "$image"
    hyprctl hyprpaper wallpaper "$monitor,$image" &
}

function setWpaperd() {
    wpaperctl next
}

function setWallpapers() {
    #wpaper is goated and doesn't require anything fancy
    if pgrep -x wpaperd >/dev/null; then
        setWpaperd
        return 0
    fi

    local monitorsList
    monitorsList=$(hyprctl monitors -j | jq '[ .[] | { name: .name, height: .height } + if (.transform == 1 or .transform == 3) then {is_vertical: true} else {is_vertical: false} end + if (.transform == 1 or .transform == 3) then {resolution: (.height | tostring + "p-Vertical")} else {resolution: (.height | tostring + "p")} end ]')
    local monitorCount
    monitorCount=$(echo "$monitorsList" | jq 'length')

    if pgrep -x hyprpaper >/dev/null; then
        hyprctl hyprpaper unload all
    fi

    for i in $(seq 0 $(("$monitorCount" - 1))); do
        local monitor
        monitor=$(echo "$monitorsList" | jq -r ".[$i].name")
        local resolution
        resolution=$(echo "$monitorsList" | jq -r ".[$i].resolution")
        local image
        image=$(getRandomFile "$WallpaperRootDir/$resolution")

        printf "%s %s\n%s\n\n" "$monitor" "$resolution" "$image"

        if pgrep -x hyprpaper >/dev/null; then
            setHyprpaper "$monitor" "$image"
        elif pgrep -x swww-daemon >/dev/null; then
            setSwww "$monitor" "$image"
        fi
    done
}

setWallpapers
