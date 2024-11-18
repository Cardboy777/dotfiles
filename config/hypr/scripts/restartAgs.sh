#!/bin/bash

if [[ $(pgrep -x "gjs") != "" ]]; then
    killall gjs
fi

ags run >/dev/null 2>&1 &
