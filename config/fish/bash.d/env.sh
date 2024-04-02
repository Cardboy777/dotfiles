#!/bin/bash

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# pyenv end

# Poetry
export PATH="$HOME/.local/bin:$PATH"

#dotnet
export DOTNETTOOL_HOME="$HOME/.dotnet/tools"
export PATH="$DOTNETTOOL_HOME:$PATH"
export ASPNETCORE_ENVIRONMENT=Development
#dotnet end

#Ship of Harikinian directory variable
export SHIP_HOME="$HOME/Games/ShipOfHarkinian"

