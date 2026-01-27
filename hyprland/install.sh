#!/bin/bash

if ! command -v pacman &>/dev/null; then
  echo "ERROR: 'pacman' command not found!"
  exit 1
fi

# Install Waybar dependency first
source "$(dirname $0)/../waybar/install.sh"

echo "--- Install Hyprland ---------"
sudo pacman -S --noconfirm --needed hyprland hyprlauncher hypridle hyprlock hyprshot swaync wlogout
