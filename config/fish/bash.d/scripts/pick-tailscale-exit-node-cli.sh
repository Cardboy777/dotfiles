#!/usr/bin/env bash

SELECTION=$(tailscale exit-node list | head --lines=-4 | tail --lines=+3 | fzf --nth 3 | awk '{print $2}')

tailscale set --exit-node="$SELECTION"
