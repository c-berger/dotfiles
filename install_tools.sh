add-apt-repository -y  ppa:neovim-ppa/stable
apt-get -y update
apt-get -y upgrade
apt-get -y install tmux exa 7zip ld-find fzf
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

# Install NodeJs >= 14.14 (required for coc.nvim plugin)
curl -sL install-node.vercel.app/lts | bash


# Setup ls-find and fzf
# create link from fd to fdfind
ln -s $(which fdfind) ~/.local/bin/fd
export PATH:$PATH:~/.local/bin
# use df-find for fzf
export FZF_DEFAULT_COMMAND='fd --color=always --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--ansi'

