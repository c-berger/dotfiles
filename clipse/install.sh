#!/bin/bash

if ! command -v yay &>/dev/null; then
  echo "ERROR: 'yay' command not found!"
  exit 1
fi

echo "--- Install Ghostty ---------"
yay -S --noconfirm --needed clipse-wayland-bin
