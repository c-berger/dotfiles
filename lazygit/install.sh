#!/bin/bash

if ! command -v pacman &>/dev/null; then
  echo "ERROR: 'pacman' command not found!"
  exit 1
fi

echo "--- Install LazyGit ---------"
sudo pacman -S --noconfirm --needed git lazygit git-delta difftastic openssh
