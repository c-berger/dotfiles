Write-Host "Installing tools via install_tools.ps1 ..." -ForegroundColor Blue

Invoke-Expression "scoop/install.ps1" 

# Install Tools via Scoop
Write-Host "Install Global Tools via Scoop" -ForegroundColor Blue
sudo scoop install 7zip git openssh --global

Write-Host "Install Local Tools via Scoop" -ForegroundColor Blue
scoop install aria2 curl grep sed less touch
scoop install eza                 # ls replacement and fork of exa; https://github.com/eza-community/eza
scoop install neovim
scoop install lazygit
scoop install delta
scoop install zoxide              # replacement for cd; https://github.com/ajeetdsouza/zoxide
scoop install ripgrep
scoop install gcc make cmake
scoop install cmder

Write-Host "Install GUI Tools via Scoop" -ForegroundColor Blue
# scoop install ditto
# scoop install speedcrunch
# scoop install sumatrapdf
# scoop install doublecmd
# scoop install windows-terminal
# scoop install keypirinha
# scoop install joplin
# scoop install autohotkey
# scoop install everything-alpha      # require alpha for version 1.5 to include dark mode
# scoop install vscode                # sync settings with GitHub account!!
# scoop install notepadplusplus

Invoke-Expression "pyenv/install.ps1"

# Install Ubuntu on WSL
# wsl --install -d Ubuntu

Write-Host "Installed tools successfully!" -ForegroundColor Green
