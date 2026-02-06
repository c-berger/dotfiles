echo '>>> Install Tools via apt package manager'
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install git zsh tmux eza unzip 7zip fd-find ripgrep zoxide
sudo apt-get -y install cmake ninja-build gcc-arm-none-eabi doxygen graphviz
sudo apt-get -y install python3 python3-pip python-is-python3 python3-venv nodejs npm

echo '>>> Install Oh-My-ZSH'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo '>>> Plugins for ZSH'
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/aloxaf/fzf-tab.git $ZSH_CUSTOM/plugins/fzf-tab

source ./nvim/install.sh
source ./tmux/install.sh
source ./lazygit/install.sh

echo '>>> Install fzf from GitHub Release Page'
FZF_VERSION=$(curl -s "https://api.github.com/repos/junegunn/fzf/releases/latest" | grep -Po '"tag_name": "\K[0-9.]+')
curl -Lo fzf.tar.gz "https://github.com/junegunn/fzf/releases/latest/download/fzf-${FZF_VERSION}-linux_amd64.tar.gz"
tar xf fzf.tar.gz -C /usr/local/bin fzf
rm -rf fzf.tar.gz


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


