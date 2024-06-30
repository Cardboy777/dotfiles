#!/bin/bash

paru -S gtk-engine-murrine sassc papirus-icon-theme bibata-cursor-git

INSTALL_DIR=~/Repositories/Tokyonight-GTK-Theme

mkdir -p $INSTALL_DIR

git clone https://github.com/Fausto-Korpsvart/Tokyonight-GTK-Theme.git $INSTALL_DIR

chmod +x $INSTALL_DIR/themes/install.sh

$INSTALL_DIR/themes/install.sh -c dark -l --tweaks moon float

sudo flatpak override --filesystem="$HOME/.themes"
sudo flatpak override --filesystem="$HOME/.icons"
sudo flatpak override --filesystem=xdg-config/gtk-4.0
sudo flatpak override --env=GTK_THEME=Tokyonight-Dark-Moon
flatpak override --user --filesystem=xdg-config/gtk-4.0