#!/bin/sh

if ! command -v paru 2>&1 >/dev/null
then
    echo Paru is already installed
    exit 0
fi

sudo pacman -S --needed base-devel

InstallDir=$HOME/tmp/paru
git clone https://aur.archlinux.org/paru.git "$InstallDir"
cd "$InstallDir" && makepkg -si

if ! command -v paru 2>&1 >/dev/null
then
    echo Paru installed successfully
    exit 0
fi
echo Paru failed to install
exit 1
