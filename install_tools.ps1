Write-Host "Installing tools via install_tools.ps1 ..." -ForegroundColor Blue
Invoke-Expression "scoop/install.ps1"
Invoke-Expression "winget/install.ps1"
Invoke-Expression "pyenv/install.ps1"

Write-Host "Install Nerd-Fonts" -ForegroundColor Blue
scoop bucket add nerd-fonts
scoop install Meslo-NF

Write-Host "Install Local Tools via Scoop" -ForegroundColor Blue
scoop install cmake
scoop install cmder
scoop install curl
scoop install delta
scoop install eza                 # ls replacement and fork of exa; https://github.com/eza-community/eza
scoop install fzf
scoop install gcc
scoop install grep
scoop install less
scoop install make
scoop install neovim
scoop install ripgrep
scoop install sed
scoop install syncthing
scoop install touch
scoop install zoxide              # replacement for cd; https://github.com/ajeetdsouza/zoxide
# scoop install imagemagick
# scoop install ghostscript
# scoop install latex

Write-Host "Install GUI/Extra Tools via Scoop" -ForegroundColor Blue
scoop install extras/autohotkey
scoop install extras/ditto
scoop install extras/doublecmd
scoop install extras/keypirinha
scoop install extras/lazygit
scoop install extras/speedcrunch
scoop install extras/windirstat
# scoop install extras/libreoffice
# scoop install extras/pdf-xchange-editor
# scoop install extras/obs-studio

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
