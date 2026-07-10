# Install psmux via scoop
if ($null -eq (Get-Command "psmux" -ErrorAction SilentlyContinue)) {
    Write-Host "Installing psmux..." -ForegroundColor Blue

    Write-Host "Add additional psmux Scoop package"
    scoop bucket add psmux https://github.com/marlocarlo/scoop-psmux

    Write-Host "Install psmux via Scoop"
    scoop install psmux/psmux

    Write-Host "Installed psmux successfully!" -ForegroundColor Green
}
else {
    Write-Host "Skip psmux installation" -ForegroundColor DarkGray
}

Write-Host "Install psmux Plugin Manager (ppm)"
Write-Host "NOTE: Might need to install plugins with <Prefix> + I" -ForegroundColor Yellow

# PowerShell sometimes blocks the background execution of ppm.ps1 due to strict
# Execution Policies. To fix this, run PowerShell as Administrator and execute
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Ensure the parent directory exists before pushing into it
$psmuxPath = Join-Path $HOME ".psmux"
if (!(Test-Path $psmuxPath)) { New-Item -ItemType Directory -Path $psmuxPath }

Push-Location $psmuxPath

# Remove existing plugins folder if it exists
if (Test-Path "plugins") { Remove-Item -Recurse -Force "plugins" }

# 1. Clone with filtering and sparse enabled
# We use --filter=blob:none to save bandwidth and --sparse to initialize the config
git clone --filter=blob:none --sparse --depth 1 https://github.com/psmux/psmux-plugins.git plugins

# 2. Move into the directory
Set-Location plugins

# 3. Explicitly set the sparse-checkout to ONLY the ppm folder (or specific files)
# Note: If the repo structure is just the files in the root, you might not even need this.
# But for a specific subfolder:
git sparse-checkout set ppm

# 4. Finalize the checkout
git checkout

Pop-Location
