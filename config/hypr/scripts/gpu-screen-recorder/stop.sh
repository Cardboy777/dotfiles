#!/bin/bash

notify="$1"

if pgrep -x "gpu-screen-reco" >/dev/null; then
    killall -SIGINT gpu-screen-recorder

    if [ "$notify" = true ]; then
        notify-send -a "gpu-sceen-recorder" -i gpu-screen-recorder -t 3000 "Recording Stopped" "Stopped Recording"
    fi
else
    echo "Not recording"
fi
