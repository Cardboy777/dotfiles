#!/bin/bash
export TERMINAL=alacritty
export EDITOR=nvim

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

#dotnet
export DOTNETTOOL_HOME="$HOME/.dotnet/tools"
export PATH="$DOTNETTOOL_HOME:$PATH"
export ASPNETCORE_ENVIRONMENT=Development
#dotnet end

#Ship of Harikinian directory variable
export SHIP_HOME="$HOME/Games/ShipOfHarkinian"

