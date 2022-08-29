# Lazygit

# Install on Windows

```bat
scoop install lazygit
scoop install delta
```

Note: delta is not working with lazygit on windows 
right now due to missing support in a package:
https://github.com/jesseduffield/lazygit/issues/1453

# Install on Linux

(e.g. Ubuntu @ WSL2)

Install Lazygit

https://github.com/jesseduffield/lazygit#ubuntu

```sh
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-35.]+')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit
```

Install Delta Pager:

```sh
wget https://github.com/dandavison/delta/releases/download/0.13.0/git-delta_0.13.0_amd64.deb
sudo dpkg -i git-delta_0.13.0_amd64.deb
```

