#!/bin/bash

if ! command -v pacman &>/dev/null; then
  echo "ERROR: 'pacman' command not found!"
  exit 1
fi

echo "--- Install Ghostty ---------"
sudo pacman -S --noconfirm --needed ghostty nerd-fonts ttf-font-awesome
