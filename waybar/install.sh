#!/bin/bash

if ! command -v pacman &>/dev/null; then
  echo "ERROR: 'pacman' command not found!"
  exit 1
fi

echo "--- Install Waybar ---------"
sudo pacman -S --noconfirm --needed waybar ttf-font-awesome
