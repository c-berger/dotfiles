# Define the paths to check for vcruntime140.dll
$pathsToCheck = @(
    "C:\Windows\System32\vcruntime140.dll",
    "C:\Windows\SysWOW64\vcruntime140.dll"
)

# Function to check if the DLL exists
function Check-DLL {
    foreach ($path in $pathsToCheck) {
        if (Test-Path $path) {
            Write-Host "Found vcruntime140.dll at: $path" -ForegroundColor Green
            return $true
        }
    }
    Write-Host "vcruntime140.dll not found" -ForegroundColor Yellow
    return $false
}

# Function to download and install Visual C++ Redistributable
function Install-VCRedist {
    $vcredistUrl = "https://aka.ms/vs/17/release/vc_redist.x64.exe"
    $downloadPath = "$env:TEMP\vc_redist.x64.exe"
    
    Write-Host "Downloading Visual C++ Redistributable..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri $vcredistUrl -OutFile $downloadPath -UseBasicParsing

    Write-Host "Installing Visual C++ Redistributable..." -ForegroundColor Cyan
    Start-Process -FilePath $downloadPath -ArgumentList "/install", "/quiet", "/norestart" -Wait

    if ($LASTEXITCODE -eq 0) {
        Write-Host "Visual C++ Redistributable installed successfully." -ForegroundColor Green
    } else {
        Write-Host "Failed to install Visual C++ Redistributable. Exit code: $LASTEXITCODE" -ForegroundColor Red
    }

    # Cleanup downloaded file
    if (Test-Path $downloadPath) {
        Remove-Item $downloadPath -Force
    }
}

# Main Script
if (-not (Check-DLL)) {
    Install-VCRedist
} else {
    Write-Host "vcruntime140.dll is already available on the system." -ForegroundColor Green
}
