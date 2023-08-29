add-apt-repository -y  ppa:neovim-ppa/stable
apt-get -y update
apt-get -y upgrade
apt-get -y install tmux exa 7zip fd-find zoxide
apt-get -y install cmake ninja-build gcc-arm-none-eabi doxygen graphviz
apt-get -y install neovim python3 python-is-python3 nodejs

# Install Lazygit from GitHub Release Page
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz -C /usr/local/bin lazygit
rm -rf lazygit.tar.gz

# Install Delta from GitHub Release Page
DELTA_VERSION=$(curl -s "https://api.github.com/repos/dandavison/delta/releases/latest" | grep -Po '"tag_name": "\K[0-9.]+')
curl -Lo delta.deb "https://github.com/dandavison/delta/releases/latest/download/git-delta_${DELTA_VERSION}_amd64.deb"
dpkg -i delta.deb
rm -rf delta.deb

# Install fzf from GitHub Release Page
FZF_VERSION=$(curl -s "https://api.github.com/repos/junegunn/fzf/releases/latest" | grep -Po '"tag_name": "\K[0-9.]+')
curl -Lo fzf.tar.gz "https://github.com/junegunn/fzf/releases/latest/download/fzf-${FZF_VERSION}-linux_amd64.tar.gz"
tar xf fzf.tar.gz -C /usr/local/bin fzf
rm -rf fzf.tar.gz

# Install NodeJs >= 14.14 (required for coc.nvim plugin)
curl -sL install-node.vercel.app/lts | bash


# Setup ls-find and fzf
# create link from fd to fdfind
ln -f -s $(which fdfind) /usr/bin/fd


