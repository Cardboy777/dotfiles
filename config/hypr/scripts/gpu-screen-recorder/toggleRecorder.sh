#!/bin/bash

notify=$1

if ! pgrep -x "gpu-screen-reco" >/dev/null; then
    "$HOME/.config/hypr/scripts/gpu-screen-recorder/start.sh" "$notify"
else
    "$HOME/.config/hypr/scripts/gpu-screen-recorder/stop.sh" "$notify"
fi
