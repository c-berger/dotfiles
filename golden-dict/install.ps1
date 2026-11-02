$ErrorActionPreference = "Stop"

# Define the installation directory (using LocalAppData so it doesn't require Admin privileges)
$installDir = "$env:LOCALAPPDATA\GoldenDict-ng"
$gdVersionFile = Join-Path $installDir "version.txt"

# ==========================================
# 1. GOLDENDICT-NG: DOWNLOAD & UNPACK 7Z
# ==========================================
Write-Host "Checking latest GoldenDict-ng release on GitHub..."
$gdApiUrl = "https://api.github.com/repos/xiaoyifang/goldendict-ng/releases/latest"
$gdRelease = Invoke-RestMethod -Uri $gdApiUrl -UseBasicParsing
$gdVersion = $gdRelease.tag_name
Write-Host "Latest Version: $gdVersion"

# Find the correct Windows 7z asset
$gdAsset = $gdRelease.assets | Where-Object { $_.name -match "-Windows-.*\.7z$" -or $_.name -match "-Windows\.7z$" } | Select-Object -First 1
if (-not $gdAsset) {
    Write-Error "Could not find the Windows .7z archive in the latest release."
    exit
}

$currentVersion = $null
if (Test-Path $gdVersionFile) {
    $currentVersion = Get-Content $gdVersionFile
}

if ($currentVersion -eq $gdVersion) {
    Write-Host "GoldenDict-ng is already up-to-date ($gdVersion)."
} else {
    Write-Host "Downloading GoldenDict-ng $gdVersion (Portable/7z)..."
    $zipPath = Join-Path $env:TEMP $gdAsset.name
    Invoke-WebRequest -Uri $gdAsset.browser_download_url -OutFile $zipPath -UseBasicParsing
    
    Write-Host "Unpacking GoldenDict-ng to $installDir..."
    if (Test-Path $installDir) { Remove-Item -Path "$installDir\*" -Recurse -Force -ErrorAction SilentlyContinue }
    if (-not (Test-Path $installDir)) { New-Item -ItemType Directory -Path $installDir -Force | Out-Null }
    
    # Use Expand-Archive to extract the 7z file natively
    Expand-Archive -Path $zipPath -DestinationPath $installDir -Force
    
    Set-Content -Path $gdVersionFile -Value $gdVersion
    Remove-Item -Path $zipPath -Force -ErrorAction SilentlyContinue
    Write-Host "Unpacking complete."
}


# ==========================================
# 2. FREEDICT DICTIONARIES: ENG-GER & GER-ENG
# ==========================================
Write-Host "`nFetching FreeDict database info..."
$fdJsonStr = (Invoke-WebRequest -Uri "https://freedict.org/freedict-database.json" -UseBasicParsing).Content

# Extract the latest StarDict direct download URLs
$engDeuUrl = [regex]::Match($fdJsonStr, '"(https://[^"]+/freedict-eng-deu-[^"]+-stardict\.tar\.(?:xz|gz|bz2))"').Groups[1].Value
$deuEngUrl = [regex]::Match($fdJsonStr, '"(https://[^"]+/freedict-deu-eng-[^"]+-stardict\.tar\.(?:xz|gz|bz2))"').Groups[1].Value

# Store dictionaries in GoldenDict's default user content path
$dictDir = "$env:APPDATA\GoldenDict\content\freedict"
if (-not (Test-Path $dictDir)) { New-Item -ItemType Directory -Path $dictDir -Force | Out-Null }

function Update-Dictionary {
    param ($dictUrl, $dictName)
    
    if (-not $dictUrl) {
        Write-Warning "Could not find URL for $dictName."
        return
    }
    
    $fileName = Split-Path $dictUrl -Leaf
    $version = [regex]::Match($fileName, "$dictName-(.+?)-stardict").Groups[1].Value
    $versionFile = Join-Path $dictDir "$dictName-version.txt"
    
    $currentDictVersion = $null
    if (Test-Path $versionFile) { $currentDictVersion = Get-Content $versionFile }
    
    if ($currentDictVersion -eq $version) {
        Write-Host "$dictName is already up-to-date (v $version)."
    } else {
        Write-Host "Downloading $dictName (v $version)..."
        $archivePath = Join-Path $env:TEMP $fileName
        Invoke-WebRequest -Uri $dictUrl -OutFile $archivePath -UseBasicParsing
        
        Write-Host "Extracting $dictName..."
        $tempExtract = Join-Path $env:TEMP "$dictName-extracted"
        if (Test-Path $tempExtract) { Remove-Item -Recurse -Force $tempExtract }
        New-Item -ItemType Directory -Path $tempExtract | Out-Null
        
        # Uses built-in Windows 10/11 tar.exe to extract the .tar.xz archive
        $tarProcess = Start-Process -FilePath "tar.exe" -ArgumentList "-xf `"$archivePath`" -C `"$tempExtract`"" -Wait -PassThru -NoNewWindow
        
        if ($tarProcess.ExitCode -eq 0) {
            Copy-Item -Path "$tempExtract\*" -Destination $dictDir -Recurse -Force
            Set-Content -Path $versionFile -Value $version
            Write-Host "$dictName updated successfully."
        } else {
            Write-Error "Failed to extract $archivePath."
        }
        
        Remove-Item -Path $archivePath -Force -ErrorAction SilentlyContinue
        Remove-Item -Path $tempExtract -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Update-Dictionary -dictUrl $engDeuUrl -dictName "freedict-eng-deu"
Update-Dictionary -dictUrl $deuEngUrl -dictName "freedict-deu-eng"


# ==========================================
# 3. CONFIGURE AUTOSTART (Via Startup Shortcut)
# ==========================================
Write-Host "`nConfiguring GoldenDict-ng Autostart via Startup folder..."

# Find the exact path to goldendict.exe within the extracted zip folder structure
$gdExePath = Get-ChildItem -Path $installDir -Filter "goldendict.exe" -Recurse | Select-Object -First 1 -ExpandProperty FullName

if ($gdExePath -and (Test-Path $gdExePath)) {
    # Get the current user's Startup folder path
    $startupFolder = [Environment]::GetFolderPath('Startup')
    $shortcutPath = Join-Path $startupFolder "GoldenDict-ng.lnk"
    
    # Create the shortcut using Windows Script Host
    $wshShell = New-Object -ComObject WScript.Shell
    $shortcut = $wshShell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $gdExePath
    $shortcut.WorkingDirectory = Split-Path $gdExePath
    $shortcut.Save()
    
    Write-Host "Autostart shortcut created successfully: $shortcutPath"
} else {
    Write-Warning "Could not locate goldendict.exe inside $installDir to configure autostart."
}

Write-Host "`nSetup complete!"
