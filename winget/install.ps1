# Install WinGet
if ($null -eq (Get-Command "winget" -ErrorAction SilentlyContinue)) {
    Write-Host "Installing WinGet..." -ForegroundColor Blue

    # Source: https://learn.microsoft.com/en-us/windows/package-manager/winget/
    $progressPreference = 'silentlyContinue'
    Write-Host "Installing WinGet PowerShell module from PSGallery..."
    Install-PackageProvider -Name NuGet -Force | Out-Null
    Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
    Write-Host "Using Repair-WinGetPackageManager cmdlet to bootstrap WinGet..."
    Repair-WinGetPackageManager -AllUsers

    Write-Host "Installed WinGet successfully!" -ForegroundColor Green
}
else {
    Write-Host "Skip WinGet installation" -ForegroundColor DarkGray
}
