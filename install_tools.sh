echo '>>> Install Tools via apt package manager'
# add-apt-repository -y  ppa:neovim-ppa/stable
sudo apt-get -y update
sudo apt-get -y upgrade
# apt-get -y install neovim
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

echo '>>> Install Neovim from GitHub Release Page'
curl -Lo nvim.tar.gz "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz"
tar xzvf nvim.tar.gz -C /opt
rm -rf nvim.tar.gz
# create link in bin folder
sudo ln -f -s /opt/nvim-linux-x86_64/bin/nvim /usr/bin/nvim

echo '>>> Install Tmux Plugin Manager'
# NOTE: Might need to install plugins with <Prefix> + I
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo '>>> Install Lazygit from GitHub Release Page'
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz -C /usr/local/bin lazygit
rm -rf lazygit.tar.gz

echo '>>> Install Delta from GitHub Release Page'
DELTA_VERSION=$(curl -s "https://api.github.com/repos/dandavison/delta/releases/latest" | grep -Po '"tag_name": "\K[0-9.]+')
curl -Lo delta.deb "https://github.com/dandavison/delta/releases/latest/download/git-delta_${DELTA_VERSION}_amd64.deb"
sudo dpkg -i delta.deb
rm -rf delta.deb

echo '>>> Install fzf from GitHub Release Page'
FZF_VERSION=$(curl -s "https://api.github.com/repos/junegunn/fzf/releases/latest" | grep -Po '"tag_name": "\K[0-9.]+')
curl -Lo fzf.tar.gz "https://github.com/junegunn/fzf/releases/latest/download/fzf-${FZF_VERSION}-linux_amd64.tar.gz"
tar xf fzf.tar.gz -C /usr/local/bin fzf
rm -rf fzf.tar.gz

echo '>>> Install difftastic from GitHub Release Page'
DIFFT_VERSION=$(curl -s "https://api.github.com/repos/wilfred/difftastic/releases/latest" | grep -Po '"tag_name": "\K[0-9.]+')
curl -Lo difft.tar.gz "https://github.com/Wilfred/difftastic/releases/download/${DIFFT_VERSION}/difft-x86_64-unknown-linux-gnu.tar.gz"
tar xf difft.tar.gz -C /usr/local/bin difft
rm -rf difft.tar.gz

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


