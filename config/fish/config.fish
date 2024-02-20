set -U fish_greeting

# Init bash scripts
set -l CONFIG_DIR $HOME/Repositories/dotfiles/config/fish
bass source $CONFIG_DIR/bash.d/aliases.sh
bass source $CONFIG_DIR/bash.d/env.sh

starship init fish | source
