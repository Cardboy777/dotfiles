#!/bin/bash

# target for the desktop audio passthrough
mic_sink=

# dmenu dialog to select the source output
sink=$(pactl list short sinks | grep -v "$mic_sink" | dmenu -i -l 10 -p "Select output:" | cut -f1)