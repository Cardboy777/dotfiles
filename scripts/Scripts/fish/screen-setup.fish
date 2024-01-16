#!/usr/bin/env fish

# Setup Screen Config on login
# for some reason xrandr/xorg doesn't detect one monitor on startup, this is the workaround
xrandr --output DP-4 --primary --mode 2560x1440 --rate 240.00 --output DP-2 --mode 1920x1080 --rate 144.00 --rotate left --right-of DP-4 --output DP-0 --mode 1920x1080 --rate 60.00 --left-of DP-4
