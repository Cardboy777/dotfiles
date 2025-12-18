#!/bin/fish

set -U fish_greeting

# Init bash scripts
set -l CONFIG_DIR "$HOME/Repositories/dotfiles/config/fish"

bass source "$CONFIG_DIR/bash.d/env.sh"
bass source "$CONFIG_DIR/bash.d/aliases.sh"

if type -q fastfetch; and not set -q TMUX
    fastfetch
end

starship init fish | source
