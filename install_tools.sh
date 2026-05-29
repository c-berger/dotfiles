echo '>>> Install Tools via apt package manager'
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install git zsh tmux eza unzip 7zip fd-find ripgrep zoxide
sudo apt-get -y install cmake ninja-build gcc-arm-none-eabi doxygen graphviz
sudo apt-get -y install python3 python3-pip python-is-python3 python3-venv nodejs npm

source ./fzf/install.sh
source ./zsh/install.sh
source ./nvim/install.sh
source ./tmux/install.sh
source ./lazygit/install.sh

echo 'Install NodeJs >= 14.14 (required for coc.nvim plugin)'
curl -sL install-node.vercel.app/lts | bash

echo 'Setup and install python packages'
python3 -m venv ~/.pynvim_env
~/.pynvim_env/bin/python3 -m pip install --upgrade pynvim
# ~/.pynvim_env/bin/python3 -m pip install --user --upgrade pynvim

echo '>>> Setup ls-find and fzf'
# create link from fd to fdfind
sudo ln -f -s $(which fdfind) /usr/bin/fd

echo '>>> Finished'
