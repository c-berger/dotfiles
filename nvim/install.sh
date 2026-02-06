#!/bin/bash

if ! command -v pacman &>/dev/null; then
  echo "ERROR: 'pacman' command not found!"
  exit 1
fi

echo "--- Install NeoVim ---------"
sudo pacman -S --noconfirm --needed neovim

# echo '>>> Install Neovim from GitHub Release Page'
#
# # Download latest release
# curl -LO "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz"
#
# # Extract to /opt/nvim
# sudo rm -rf /opt/nvim
# sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
# sudo mv /opt/nvim-linux-x86_64 /opt/nvim
#
# # Cleanup
# rm -rf nvim-linux-x86_64.tar.gz
#
# # Create link in bin folder
# sudo ln -f -s /opt/nvim/bin/nvim /usr/bin/nvim
