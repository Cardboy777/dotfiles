#!/bin/bash

device_name="Scarlett 2i2 3rd Gen Input 1";

# get the wireplumber device id for the microphone
device_id=$(wpctl status | grep "$device_name" | grep -oEm 1 '[[:digit:]]+\.' | cut -d'.' -f1 | head -n 1);

volume=$(wpctl get-volume "$device_id")

iconName="unmuted";

if [[ $volume == *"[MUTED]"* ]]; then
    iconName="muted"
fi

echo "{\"text\":\"\", \"alt\": \"$iconName\", \"class\": \"$iconName\"}"
