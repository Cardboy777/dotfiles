#!/bin/bash

if [[ $(pgrep -x "ags") != "" ]]
then
    killall ags
    ags > /dev/null 2>&1 &
else
    ags > /dev/null 2>&1 &
fi
