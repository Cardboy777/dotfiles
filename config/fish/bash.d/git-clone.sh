#!/usr/bin/env bash

# azureairway=az repos list --org 'https://dev.azure.com/passageways/' -p 'Airway' | jq '.[] | .name,.remoteUrl'
# github=gh repo list --json 'name,url' -q '.[] | .name,.url'

selected=$({ az repos list --org 'https://dev.azure.com/passageways/' -p 'Airway' | jq '.[] | .name,.remoteUrl'; gh repo list --json 'name,url' -q '.[] | .name,.url'; } | fzf)

if [[ -z $selected ]]; then
    exit 0
fi

# git clone "$selected"
