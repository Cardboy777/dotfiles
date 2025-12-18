#!/bin/bash

INSTALL_DIR=~/Repositories/Tokyonight-GTK-Theme

mkdir -p $INSTALL_DIR

git clone https://github.com/Fausto-Korpsvart/Tokyonight-GTK-Theme.git $INSTALL_DIR

chmod +x $INSTALL_DIR/themes/install.sh

$INSTALL_DIR/themes/install.sh -c dark -l --tweaks moon float

# Setup Flatpak Overrides
sudo flatpak override --filesystem="$HOME/.themes"
sudo flatpak override --filesystem="$HOME/.icons"
sudo flatpak override --filesystem=xdg-config/gtk-4.0
sudo flatpak override --env=GTK_THEME=Tokyonight-Dark-Moon
sudo flatpak override --env=QT_QPA_PLATFORMTHEME=gtk3
flatpak override --user --filesystem=xdg-config/gtk-4.0

# Setup Root User Themes
ln -s "$HOME/.gtkrc-2.0" /etc/gtk-2.0/gtkrc
ln -s "$HOME/.config/gtk-3.0/settings.ini" /etc/gtk-3.0/settings.ini
ln -s "$HOME/.themes" /root/.themes

echo "==Configure with tools=="
printf 'GTK-2:\t lxappearance\n'
printf 'GTK-3:\t nwg-look\n'
printf 'QT5:\t qt5ct\n'
printf 'QT6:\t qt6ct\n'
