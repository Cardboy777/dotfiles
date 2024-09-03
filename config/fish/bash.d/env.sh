#!/bin/bash
export TERMINAL=alacritty
export EDITOR=nvim

#mason bin
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v -- pyenv > /dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
# pyenv end

# Poetry
export PATH="$HOME/.local/bin:$PATH"

#dotnet
export DOTNETTOOL_HOME="$HOME/.dotnet/tools"
export PATH="$DOTNETTOOL_HOME:$PATH"
export ASPNETCORE_ENVIRONMENT=Development
#dotnet end

# asdf
export ASDF_CONFIG_FILE="$HOME/.config/asdf/.asdfrc"
source /opt/asdf-vm/asdf.sh

#Ship of Harikinian directory variable
export SHIP_HOME="$HOME/Games/ShipOfHarkinian"

