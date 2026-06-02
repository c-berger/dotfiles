#!/bin/bash

echo '>>> Install Tools via apt package manager'
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install git zsh tmux eza unzip 7zip fd-find ripgrep zoxide
sudo apt-get -y install python3 python3-pip python-is-python3 python3-venv nodejs npm
sudo apt-get -y install cmake ninja-build gcc-arm-none-eabi doxygen graphviz
sudo apt-get -y install gdb gcovr gcc-multilib g++-multilib libc6-dev-i386

# create a link to alias fd to fdfind for fzf
sudo ln -f -s $(which fdfind) /usr/bin/fd

echo '>>> Install Tools via scipts'
source ./fzf/install.sh
source ./lazygit/install.sh
source ./nvim/install.sh
source ./tmux/install.sh
source ./yazi/install.sh
source ./zsh/install.sh

echo '>>> Finished'
