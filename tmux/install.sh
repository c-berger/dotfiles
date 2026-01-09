#!/bin/bash

echo '>>> Install Tmux'

sudo apt-get -y install tmux

echo '>>> Install Tmux Plugin Manager'
# NOTE: Might need to install plugins with <Prefix> + I
rm -rf ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


