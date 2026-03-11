# Install Scoop
if ($null -eq (Get-Command "scoop" -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Scoop..." -ForegroundColor Blue

    Write-Host "Set required privileges for current user"
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

    Write-Host "Install and Setup Scoop"
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

    Write-Host "Install optional tools for Scoop"
    scoop install 7zip aria2 git
    scoop config aria2-warning-enabled false

    Write-Host "Add additional Scoop packages"
    # scoop bucket add main
    scoop bucket add extras
    # scoop bucket add versions
    # scoop bucket add nerd-font

    Write-Host "Installed Scoop successfully!" -ForegroundColor Green
}
else {
    Write-Host "Skip Scoop installation" -ForegroundColor DarkGray
}
