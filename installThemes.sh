#!/bin/bash

paru -S gtk-engine-murrine sassc papirus-icon-theme bibata-cursor-git lxappearance nwg-look qt6gtk2 qt5-styleplugins qt5ct qt6ct

INSTALL_DIR=~/Repositories/Tokyonight-GTK-Theme

mkdir -p $INSTALL_DIR

git clone https://github.com/Fausto-Korpsvart/Tokyonight-GTK-Theme.git $INSTALL_DIR

chmod +x $INSTALL_DIR/themes/install.sh

$INSTALL_DIR/themes/install.sh -c dark -l --tweaks moon float

sudo flatpak override --filesystem="$HOME/.themes"
sudo flatpak override --filesystem="$HOME/.icons"
sudo flatpak override --filesystem=xdg-config/gtk-4.0
sudo flatpak override --env=GTK_THEME=Tokyonight-Dark-Moon
sudo flatpak override --env=QT_QPA_PLATFORMTHEME=gtk2
flatpak override --user --filesystem=xdg-config/gtk-4.0

echo "==Configure with tools=="
printf 'GTK-2:\t lxappearance\n'
printf 'GTK-3:\t nwg-look\n'
printf 'QT5:\t qt5ct\n'
printf 'QT6:\t qt6ct\n'
