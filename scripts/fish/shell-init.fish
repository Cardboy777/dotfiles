#!/usr/bin/env fish

set fish_greeting

if test -e ~/Scripts/fish/env.fish
    source ~/Scripts/fish/env.fish
else
    echo "[ERR] env config does not exist!"
end

if test -e ~/Scripts/fish/aliases.fish
    source ~/Scripts/fish/aliases.fish
else
    echo "[ERR] alias config does not exist!"
end
