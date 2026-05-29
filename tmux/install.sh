#!/bin/bash

if command -v pacman &>/dev/null; then
    echo "--- Install TMUX via Pacman ---------"
    sudo pacman -S --noconfirm --needed tmux

else
    echo "--- Install TMUX via apt-get ---------"
    sudo apt-get -y install tmux

    echo "--- Install TMUX Plugin Manager ---------"
    # NOTE: Might need to install plugins with <Prefix> + I
    rm -rf ~/.tmux/plugins/tpm
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

fi
