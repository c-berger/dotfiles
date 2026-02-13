$branch="main"

Write-Host "Install Visual C++ Redistributable" -ForegroundColor Blue
Invoke-WebRequest "https://raw.githubusercontent.com/c-berger/dotfiles/refs/heads/$branch/tools/install_vc_redist.ps1" | Invoke-Expression

Write-Host "Install Keyboard Layout" -ForegroundColor Blue
Invoke-WebRequest "https://raw.githubusercontent.com/c-berger/dotfiles/refs/heads/$branch/tools/install_eurkey.ps1" | Invoke-Expression

Write-Host "Install Fonts" -ForegroundColor Blue
Invoke-WebRequest "https://raw.githubusercontent.com/c-berger/dotfiles/refs/heads/$branch/tools/install_fonts.ps1" | Invoke-Expression

Write-Host "Install Scoop" -ForegroundColor Blue
Invoke-WebRequest "https://raw.githubusercontent.com/c-berger/dotfiles/refs/heads/$branch/scoop/install.ps1" | Invoke-Expression

# Write-Host "Install Tools" -ForegroundColor Blue
# Invoke-WebRequest "https://raw.githubusercontent.com/c-berger/dotfiles/refs/heads/$branch/install_tools.ps1" | Invoke-Expression

Write-Host "Clone and Install Dotfiles" -ForegroundColor Blue
git clone --recursive -b $branch git@github.com:c-berger/dotfiles.git $ENV:USERPROFILE\.dotfiles
cd $ENV:USERPROFILE\.dotfiles
sudo ./install_files.ps1
