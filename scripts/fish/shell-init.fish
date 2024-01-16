#!/usr/bin/env fish

set fish_greeting

if test -e ~/Repositories/dotfiles/scripts/fish/env.fish
    source ~/Repositories/dotfiles/scripts/fish/env.fish
else
    echo "[ERR] env config does not exist!"
end

if test -e ~/Repositories/dotfiles/scripts/fish/aliases.fish
    source ~/Repositories/dotfiles/scripts/fish/aliases.fish
else
    echo "[ERR] alias config does not exist!"
end
