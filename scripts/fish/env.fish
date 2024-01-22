#!/usr/bin/env fish

# pnpm
export PNPM_HOME="/home/reid/.local/share/pnpm"
export PATH="$PATH:$PNPM_HOME"
# pnpm end

# dotnet tools
export DOTNETTOOL_HOME="$HOME/.dotnet/tools"
export PATH="$PATH:$DOTNETTOOL_HOME"
export ASPNETCORE_ENVIRONMENT=Development
# dotnet tools end


# use kwallet for git credentials
# export GIT_ASKPASS=/usr/bin/ksshaskpass
# export SSH_ASKPASS_REQUIRE=prefer


#Ship of Harikinian directory variable
export SHIP_HOME="/mnt/ssd1/reid/Games/ShipOfHarkinian"
