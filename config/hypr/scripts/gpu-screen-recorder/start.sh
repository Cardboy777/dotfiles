#!/bin/bash

notify=$1

if ! pgrep -x "gpu-screen-reco" >/dev/null; then
    monitor="$(hyprctl monitors -j | jq -r '.[] | select(.name=="DP-1")| .name')"
    audio="$(pactl get-default-sink).monitor|$(pactl get-default-source)"
    outputDir="$HOME/Videos/gpu-screen-recorder"
    frameRate=60
    fileType="mkv"
    colorRange="full"
    replaySeconds=60

    if [ "$notify" = true ]; then
        notify-send -a "gpu-sceen-recorder" -i gpu-screen-recorder -t 3000 "Recording Started" "Started Recording"
    fi

    # For AGS to know that the recording is in progress
    touch "$HOME/.config/hypr/scripts/gpu-screen-recorder/RUNNING"

    gpu-screen-recorder -w "$monitor" -a "$audio" -f $frameRate -c $fileType -r $replaySeconds -cr $colorRange -mf "yes" -o "$outputDir"

else
    echo "Recording already in progress"
fi
