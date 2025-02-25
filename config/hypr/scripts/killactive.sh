#!/bin/bash

# if [ "$(hyprctl activewindow -j | jq -r ".class")" = "Steam" ]; then
#     xdotool getactivewindow windowunmap
# elif [ "$(hyprctl activewindow -j | jq -r ".class")" = "vesktop" ]; then
#     xdotool getactivewindow windowunmap
# else
hyprctl dispatch killactive ""
# fi
