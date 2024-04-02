#!/bin/bash
# this scripts finds the wireplumber device id for the microphone and toggles the mute state

device_name="Scarlett 2i2 3rd Gen Input 1 Mic/Inst/Line";

# get the wireplumber device id for the microphone
device_id=$(wpctl status | grep "$device_name" | grep -oEm 1 '[[:digit:]]+\.' | cut -d'.' -f1 | head -n 1);

echo "Device Id: $device_id";

wpctl set-mute "$device_id" toggle;

volume=$(wpctl get-volume "$device_id");

echo "'$device_name' Volume is $volume";

audio="$HOME/Music/_discord/unmute.mp3"
if [[ $volume == *"[MUTED]"* ]]; then
  audio="$HOME/Music/_discord/mute.mp3"
fi

pkill -RTMIN+8 waybar

play "$audio" trim 0 1 vol 0.15
