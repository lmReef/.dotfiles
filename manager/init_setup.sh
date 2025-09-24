#!/bin/bash

echo "- installing base packages..."

sudo pacman -Sy --needed base-devel git fish zsh

echo "- checking other core tools..."

if ! paru -V &>/dev/null; then
    echo -e "\t- installing paru package manager + AUR helper..."
    pushd ~/Downloads
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
    popd
else
    echo -e "\t- paru found"
fi

echo "- setup done"
