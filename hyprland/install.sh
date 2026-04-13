#!/bin/bash

if ! command -v yay &>/dev/null; then
    echo "ERROR: 'yay' command not found!"
    exit 1
fi

# Install Waybar dependency first
source "$(dirname ${BASH_SOURCE[0]})/../waybar/install.sh"

echo "--- Install Hyprland ---------"
yay -S --noconfirm --needed hyprland hyprlauncher hypridle hyprlock hyprshot hyprshutdown swaync wlogout
