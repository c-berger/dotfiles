#!/bin/bash

if ! command -v pacman &>/dev/null; then

    echo "--- Install NeoVim via Pacman ---------"
    sudo pacman -S --noconfirm --needed neovim

else

    echo "--- Install NeoVim from GitHub Release Page ---------"
    curl -LO "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz"

    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
    sudo mv /opt/nvim-linux-x86_64 /opt/nvim
    sudo ln -f -s /opt/nvim/bin/nvim /usr/bin/nvim

    rm -rf nvim-linux-x86_64.tar.gz

fi
