#!/bin/bash
export TERMINAL=kitty
export EDITOR=nvim
export BROWSER=brave

#mason bin
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v -- pyenv >/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
# pyenv end

# Poetry
export PATH="$HOME/.local/bin:$PATH"

# dotnet
export DOTNETTOOL_HOME="$HOME/.dotnet/tools"
export PATH="$DOTNETTOOL_HOME:$PATH"
export ASPNETCORE_ENVIRONMENT=Development
export DOTNET_CLI_TELMETRY_OPTOUT=1
#dotnet end

#Ship of Harikinian directory variable
export SHIP_HOME="$HOME/Games/ShipOfHarkinian"
