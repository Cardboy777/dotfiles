#!/usr/bin/env bash

# Get exit node list, strip header/footer
NODES=$(tailscale exit-node list | head --lines=-4 | tail --lines=+3)

# Build menu: "None" first, then "City, Country (hostname)" for each node
MENU=$(
	echo "None"
	echo "$NODES" | awk '{print $3 ", " $4 " (" $2 ")"}'
)

# Show rofi menu
SELECTION=$(echo "$MENU" | rofi -dmenu -p "Exit Node")

# Handle selection
if [[ -z "$SELECTION" ]]; then
	exit 0 # User cancelled
elif [[ "$SELECTION" == "None" ]]; then
	tailscale set --exit-node=""
else
	# Extract hostname from "City, Country (hostname)" format
	NODE=$(echo "$SELECTION" | sed 's/.*(\(.*\))/\1/')
	tailscale set --exit-node="$NODE"
fi
