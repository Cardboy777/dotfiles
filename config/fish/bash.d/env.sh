#!/bin/bash

#in case these aren't set for some reason
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

export TERMINAL=ghostty
export EDITOR=nvim
export BROWSER=brave
export MANPAGER="less -R --use-color -Dd+r -Du+b"

#mason bin
export PATH="$XDG_DATA_HOME/nvim/mason/bin:$PATH"

# pnpm
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
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

#go
export PATH="$HOME/go/bin:$PATH"
