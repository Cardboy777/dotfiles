#!/bin/bash

if [[ $(pgrep -x "gjs") != "" ]]; then
    killall -KILL gjs
fi

mkdir -p "$XDG_STATE_HOME/ags"

ags run >"$XDG_STATE_HOME/ags/ags.log" 2>&1 &
