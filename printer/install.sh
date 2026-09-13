#!/bin/bash

if ! command -v pacman &>/dev/null; then
    echo "ERROR: 'pacman' command not found!"
    exit 1
fi

if ! command -v yay &>/dev/null; then
    echo "ERROR: 'yay' command not found!"
    exit 1
fi

echo "--- Install Printer Driver ---------"
sudo pacman -S --noconfirm --needed cups cups-pdf system-config-printer

echo "--- Install Scanner Driver ---------"
sudo pacman -S --noconfirm --needed sane sane-airscan simple-scan tesseract-data-eng tesseract-data-deu
sudo yay -S --noconfirm --needed ocrmypdf

echo "Please setup 'Document Scanner' to call"
echo "'/home/christoph/.dotfiles/printer/ocrmypdf.sh' for postprocessing"
