# Define the download URL for MesloLGS NF
$fontUrls = @(
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
)

# Loop through each font URL and download
foreach ($fontUrl in $fontUrls) {

    $fontFileName = [System.IO.Path]::GetFileName($fontUrl)
    $fontFileName = $fontFileName.replace('%20',' ')
    $fontName = $fontFileName.Replace(".ttf","")
    $localFontPath = Join-Path -Path $env:SystemRoot -ChildPath "\Fonts\$fontFileName"
    
    Write-Host "Installing Font: $fontName"

    Invoke-WebRequest -Uri $fontUrl -OutFile $localFontPath
    
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" `
        -Name "$fontName (TrueType)" `
        -Value "$localFontPath" -PropertyType String
}

Write-Host "All fonts have been installed."
