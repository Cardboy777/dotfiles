#!/bin/bash

notify="$1"

if pgrep -x "gpu-screen-reco" >/dev/null; then
    killall -SIGUSR1 gpu-screen-recorder

    if [ "$notify" = true ]; then
        notify-send -a "gpu-sceen-recorder" -i gpu-screen-recorder -t 3000 "Replay Saved" "Last 60 seconds Saved"
    fi
else
    echo "Not recording"
fi
