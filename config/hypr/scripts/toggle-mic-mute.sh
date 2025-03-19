#!/bin/bash
# this scripts finds the wireplumber device id for the microphone and toggles the mute state

device_name="alsa_input\.usb-Focusrite_Scarlett_2i2_USB_Y8QP6EE12B1E90-00\.HiFi__Mic1__source \[Audio\/Source\]"

# get the wireplumber device id for the microphone
device_id=$(wpctl status | grep "$device_name" | grep -oEm 1 '[[:digit:]]+\.' | cut -d'.' -f1 | head -n 1)

echo "Device Id: $device_id"

wpctl set-mute "$device_id" toggle

volume=$(wpctl get-volume "$device_id")

echo "'$device_name' Volume is $volume"

audio="$HOME/Music/_discord/unmute.mp3"
if [[ $volume == *"[MUTED]"* ]]; then
  audio="$HOME/Music/_discord/mute.mp3"
fi

pkill -RTMIN+8 waybar

ffplay -v 0 -volume 30 -nodisp -autoexit "$audio"
