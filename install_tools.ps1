Write-Host "Installing tools via install_tools.ps1 ..." -ForegroundColor Blue
Invoke-Expression "scoop/install.ps1"
Invoke-Expression "winget/install.ps1"
Invoke-Expression "pyenv/install.ps1"

Write-Host "Install Global Tools via Scoop" -ForegroundColor Blue
sudo scoop install 7zip git openssh --global

Write-Host "Install Nerd-Fonts" -ForegroundColor Blue
scoop bucket add nerd-fonts
scoop install Meslo-NF

Write-Host "Install Local Tools via Scoop" -ForegroundColor Blue
scoop install aria2
scoop install cmake
scoop install cmder
scoop install curl
scoop install delta
scoop install eza                 # ls replacement and fork of exa; https://github.com/eza-community/eza
scoop install gcc
scoop install grep
scoop install lazygit
scoop install less
scoop install make
scoop install neovim
scoop install ripgrep
scoop install sed
scoop install touch
scoop install zoxide              # replacement for cd; https://github.com/ajeetdsouza/zoxide
# scoop install imagemagick
# scoop install ghostscript
# scoop install latex

Write-Host "Install GUI Tools via Scoop" -ForegroundColor Blue
scoop install autohotkey
scoop install ditto
scoop install doublecmd
scoop install keypirinha
scoop install speedcrunch
# scoop install libreoffice
# scoop install windirstat
# scoop install pdf-xchange-editor
# scoop install obs-studio

Write-Host "Install GUI Tools via WinGet" -ForegroundColor Blue
winget install Zen-Team.Zen-Browser
winget install Joplin.Joplin
winget install voidtools.Everything.Alpha      # require alpha for version 1.5 to include dark mode
winget install Microsoft.VisualStudioCode      # sync settings with GitHub account!!
# winget install Microsoft.WindowsTerminal
winget install Notepad++.Notepad++
winget install SumatraPDF.SumatraPDF
winget install KeePassXCTeam.KeePassXC
# winget install VideoLAN.VLC
# winget install SteffenBruentjen.EurKEY
winget install Atlassian.Sourcetree


# Install Ubuntu on WSL
# wsl --install -d Ubuntu

Write-Host "Installed tools successfully!" -ForegroundColor Green
