# #############################################################################
# Initializes a complete fresh Windows (10) installation by installing git via
# scoop (which is also installed) and then cloning the repsitory.
#
# This script can be invoked via a web request with the following command:
# ```powershell
# Invoke-WebRequest https://raw.githubusercontent.com/c-berger/dotfiles/refs/heads/main/tools/init_windows.ps1 | Invoke-Expression
# ```
# #############################################################################

$branch="main"
$repoPath = Get-Location
$script = "scoop\install.ps1"
$url = "https://raw.githubusercontent.com/c-berger/dotfiles/refs/heads/$branch/$script"
Invoke-WebRequest $url | Invoke-Expression

Write-Host "Install git via scoop"
if ($null -eq (Get-Command "git" -ErrorAction SilentlyContinue)) {
  scoop install git
}

Write-Host "Clone and Install Dotfiles" -ForegroundColor Blue
git clone --recursive -b $branch https://github.com/c-berger/dotfiles.git $ENV:USERPROFILE\.dotfiles
cd $ENV:USERPROFILE\.dotfiles

# Switch to SSH remote URL
git remote set-url --delete origin git@github.com:c-berger/dotfiles.git

