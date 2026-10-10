#!/bin/bash

if ! command -v pacman &>/dev/null; then
    echo "ERROR: 'pacman' command not found!"
    exit 1
fi

echo "--- Install Zsh via Pacman ---------"
sudo pacman -S --noconfirm --needed doublecmd-qt6 qt6-webengine # req. for PDF preview plugin
