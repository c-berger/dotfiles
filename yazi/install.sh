#!/bin/bash

if command -v pacman &>/dev/null; then
    echo "--- Install Yazi and Dpendencies via Pacman ---------"
    sudo pacman -S --noconfirm --needed yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick
else
    echo "--- Install Yazi Dependencies via apt ---------"
    sudo apt-get -y install wget unzip ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick

    echo "--- Install Yazi via GitHub Release Page ---------"
    wget -qO yazi.zip https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-gnu.zip
    unzip -q yazi.zip -d yazi-temp
    sudo mv yazi-temp/*/{ya,yazi} /usr/local/bin
    rm -rf yazi-temp yazi.zip
fi
