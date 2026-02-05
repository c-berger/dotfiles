#!/bin/bash

if ! command -v pacman &>/dev/null; then
  echo "ERROR: 'pacman' command not found!"
  exit 1
fi

# Install Yay
if ! command -v yay &>/dev/null; then
  sudo pacman -S yay
fi

source "$(dirname ${BASH_SOURCE[0]})/zsh/install.sh"
source "$(dirname ${BASH_SOURCE[0]})/nvim/install.sh"
source "$(dirname ${BASH_SOURCE[0]})/hyprland/install.sh"
source "$(dirname ${BASH_SOURCE[0]})/lazygit/install.sh"
source "$(dirname ${BASH_SOURCE[0]})/yazi/install.sh"

sudo pacman -S --noconfirm --needed vim tmux
sudo pacman -S --noconfirm --needed syncthing
sudo pacman -S --noconfirm --needed joplin-desktop
