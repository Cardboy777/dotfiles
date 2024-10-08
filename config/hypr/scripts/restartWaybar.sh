#!/bin/bash

CONFIG="$HOME/.config/waybar/config"
STYLE="$HOME/.config/waybar/style.css"

if [[ $(pgrep -x "waybar") != "" ]]
then
    killall waybar
    waybar -c "$CONFIG" -s "$STYLE" > /dev/null 2>&1 &
else
    waybar -c "$CONFIG" -s "$STYLE" > /dev/null 2>&1 &
fi
