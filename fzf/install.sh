#!/bin/bash

if command -v pacman &>/dev/null; then

    echo "--- Install Zsh via Pacman ---------"
    sudo pacman -S --noconfirm --needed fzf

else

    echo "--- Install FZF from GitHub Release Page ---------"
    FZF_VERSION=$(curl -s "https://api.github.com/repos/junegunn/fzf/releases/latest" | grep -Po '"tag_name": "v?\K[0-9.]+')
    curl -Lo fzf.tar.gz "https://github.com/junegunn/fzf/releases/latest/download/fzf-${FZF_VERSION}-linux_amd64.tar.gz"
    sudo tar xf fzf.tar.gz -C /usr/local/bin fzf
    rm -rf fzf.tar.gz

fi
