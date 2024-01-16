#!/bin/bash

if [ "$XDG_SESSION_DESKTOP" == "KDE" ]
then
    # Setup Screen Config on login
    # for some reason xrandr/xorg doesn't detect one monitor on startup, this is the workaround
    xrandr --output DP-1 --primary --mode 2560x1440 --rate 240.00 --output HDMI-A-1 --mode 1920x1080 --rate 144.00 --rotate left --right-of DP-1 --output DP-2 --mode 1920x1080 --rate 60.00 --left-of DP-1
else
    # we're in sway
    swaymsg output HDMI-A-1 pos 4480 0 transform 270 clockwise
    swaymsg output "*" bg "/mnt/ssd1/home/re…s/Wallpapers/Misc/hex.jpg" fill
fi

