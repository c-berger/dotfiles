$ErrorActionPreference = "Stop"

# Define the installation directory
$installDir = "$env:LOCALAPPDATA\GoldenDict-ng"
$gdVersionFile = Join-Path $installDir "version.txt"

# ==========================================
# 1. GOLDENDICT-NG: DOWNLOAD & UNPACK 7Z
# ==========================================
Write-Host "Checking latest GoldenDict-ng release on GitHub..."
$gdApiUrl = "https://api.github.com/repos/xiaoyifang/goldendict-ng/releases/latest"
$gdRelease = Invoke-RestMethod -Uri $gdApiUrl -UseBasicParsing
$gdVersion = $gdRelease.tag_name

$gdAsset = $gdRelease.assets | Where-Object { $_.name -match "Windows.*\.7z$" } | Select-Object -First 1
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
    Write-Host "Downloading GoldenDict-ng $gdVersion (Portable 7z)..."
    $archivePath = Join-Path $env:TEMP $gdAsset.name
    Invoke-WebRequest -Uri $gdAsset.browser_download_url -OutFile $archivePath -UseBasicParsing

    Write-Host "Unpacking GoldenDict-ng to $installDir..."
    if (Test-Path $installDir) { Remove-Item -Path "$installDir\*" -Recurse -Force -ErrorAction SilentlyContinue }
    if (-not (Test-Path $installDir)) { New-Item -ItemType Directory -Path $installDir -Force | Out-Null }

    $7zPath = "${env:ProgramFiles}\7-Zip\7z.exe"
    if (Test-Path $7zPath) {
        $extractProcess = Start-Process -FilePath $7zPath -ArgumentList "x `"$archivePath`" -o`"$installDir`" -y" -Wait -PassThru -NoNewWindow
        $exitCode = $extractProcess.ExitCode
    } else {
        Write-Host "7-Zip not found. Attempting native extraction..."
        $extractProcess = Start-Process -FilePath "tar.exe" -ArgumentList "-xf `"$archivePath`" -C `"$installDir`"" -Wait -PassThru -NoNewWindow
        $exitCode = $extractProcess.ExitCode
    }

    if ($exitCode -eq 0) {
        Set-Content -Path $gdVersionFile -Value $gdVersion
        Remove-Item -Path $archivePath -Force -ErrorAction SilentlyContinue
        Write-Host "Unpacking complete."
    } else {
        Write-Error "Extraction failed. Ensure 7-Zip is installed or you are on Windows 11 23H2+."
        exit
    }
}


# ==========================================
# 2. FREEDICT DICTIONARIES: NATIVE JSON PARSING
# ==========================================
Write-Host "`nFetching FreeDict database info..."
$fdJson = Invoke-RestMethod -Uri "https://freedict.org/freedict-database.json" -UseBasicParsing

$dictList = if ($fdJson.dictionaries) { $fdJson.dictionaries } else { $fdJson }

function Get-DictUrl ($langPair) {
    $dict = $dictList | Where-Object { $_.name -eq $langPair }
    if ($dict -and $dict.releases) {
        $stardict = $dict.releases | Where-Object { $_.format -eq 'stardict' } | Select-Object -First 1
        if ($stardict) { return $stardict.URL }
    }

    $raw = $fdJson | ConvertTo-Json -Depth 10
    $match = [regex]::Match($raw, '"(https?://[^"]*?' + $langPair + '[^"]*?stardict\.tar\.[a-z0-9]+)"', 'IgnoreCase')
    if ($match.Success) { return $match.Groups[1].Value }

    return $null
}

$engDeuUrl = Get-DictUrl "eng-deu"
$deuEngUrl = Get-DictUrl "deu-eng"

$dictDir = "$env:APPDATA\GoldenDict\content\freedict"
if (-not (Test-Path $dictDir)) { New-Item -ItemType Directory -Path $dictDir -Force | Out-Null }

function Update-Dictionary {
    param ($dictUrl, $dictName)

    if (-not $dictUrl) {
        Write-Warning "Could not find URL for $dictName."
        return
    }

    $fileName = Split-Path $dictUrl -Leaf
    $versionMatch = [regex]::Match($fileName, "$dictName-(.+?)-stardict", 'IgnoreCase')
    $version = if ($versionMatch.Success) { $versionMatch.Groups[1].Value } else { "latest" }

    $versionFile = Join-Path $dictDir "$dictName-version.txt"
    $currentDictVersion = $null

    if (Test-Path $versionFile) { $currentDictVersion = Get-Content $versionFile }

    if ($currentDictVersion -eq $version -and $version -ne "latest") {
        Write-Host "$dictName is already up-to-date (v $version)."
    } else {
        Write-Host "Downloading $dictName (v $version)..."
        $dictArchivePath = Join-Path $env:TEMP $fileName
        Invoke-WebRequest -Uri $dictUrl -OutFile $dictArchivePath -UseBasicParsing

        Write-Host "Extracting $dictName..."
        $tempExtract = Join-Path $env:TEMP "$dictName-extracted"
        if (Test-Path $tempExtract) { Remove-Item -Recurse -Force $tempExtract }
        New-Item -ItemType Directory -Path $tempExtract | Out-Null

        $tarProcess = Start-Process -FilePath "tar.exe" -ArgumentList "-xf `"$dictArchivePath`" -C `"$tempExtract`"" -Wait -PassThru -NoNewWindow

        if ($tarProcess.ExitCode -eq 0) {
            Copy-Item -Path "$tempExtract\*" -Destination $dictDir -Recurse -Force
            Set-Content -Path $versionFile -Value $version
            Write-Host "$dictName updated successfully."
        } else {
            Write-Error "Failed to extract $dictArchivePath."
        }

        Remove-Item -Path $dictArchivePath -Force -ErrorAction SilentlyContinue
        Remove-Item -Path $tempExtract -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Update-Dictionary -dictUrl $engDeuUrl -dictName "eng-deu"
Update-Dictionary -dictUrl $deuEngUrl -dictName "deu-eng"


# ==========================================
# 3. ADD DICTIONARY FOLDER TO GOLDENDICT XML
# ==========================================
Write-Host "`nRegistering dictionary paths in GoldenDict config..."
$configDir = "$env:APPDATA\GoldenDict"
$configFile = Join-Path $configDir "config"

if (-not (Test-Path $configDir)) { New-Item -ItemType Directory -Path $configDir -Force | Out-Null }

$normalizedDictDir = $dictDir -replace '\\', '/'

if (Test-Path $configFile) {
    [xml]$gdConfig = Get-Content $configFile
} else {
    [xml]$gdConfig = @"
<?xml version="1.0" encoding="utf-8"?>
<config>
  <paths></paths>
</config>
"@
}

# Use explicit XPath selection to prevent PowerShell from casting empty nodes to Strings
$configNode = $gdConfig.SelectSingleNode("/config")
if (-not $configNode) {
    $configNode = $gdConfig.CreateElement("config")
    $gdConfig.AppendChild($configNode) | Out-Null
}

$pathsNode = $configNode.SelectSingleNode("paths")
if (-not $pathsNode) {
    $pathsNode = $gdConfig.CreateElement("paths")
    $configNode.AppendChild($pathsNode) | Out-Null
}

# Check if path already exists
$existingPaths = $pathsNode.SelectNodes("path") | Where-Object { $_.InnerText -replace '\\', '/' -eq $normalizedDictDir }

if (-not $existingPaths) {
    $newPathNode = $gdConfig.CreateElement("path")
    $newPathNode.SetAttribute("recursive", "1")
    $newPathNode.InnerText = $normalizedDictDir
    $pathsNode.AppendChild($newPathNode) | Out-Null

    $gdConfig.Save($configFile)
    Write-Host "Successfully injected freedict path into GoldenDict config."
} else {
    Write-Host "Dictionary path is already configured in GoldenDict."
}


# ==========================================
# 4. CONFIGURE AUTOSTART (Via Startup Shortcut)
# ==========================================
Write-Host "`nConfiguring GoldenDict-ng Autostart via Startup folder..."

$gdExePath = Get-ChildItem -Path $installDir -Filter "goldendict.exe" -Recurse | Select-Object -First 1 -ExpandProperty FullName

if ($gdExePath -and (Test-Path $gdExePath)) {
    $startupFolder = [Environment]::GetFolderPath('Startup')
    $shortcutPath = Join-Path $startupFolder "GoldenDict-ng.lnk"

    $wshShell = New-Object -ComObject WScript.Shell
    $shortcut = $wshShell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $gdExePath
    $shortcut.WorkingDirectory = Split-Path $gdExePath
    $shortcut.Save()

    Write-Host "Autostart shortcut created/verified successfully: $shortcutPath"
} else {
    Write-Warning "Could not locate goldendict.exe inside $installDir to configure autostart."
}

Write-Host "`nSetup complete! The dictionaries will be indexed automatically when you launch the application."
