# Define the download URL for MesloLGS NF
$fontUrls = @(
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
)
$FontCLSID = 0x14

# Define the local font installation path
$fontsFolder = "$env:SystemRoot\Fonts"

# Loop through each font URL and download
foreach ($fontUrl in $fontUrls) {

    $fontFileName = [System.IO.Path]::GetFileName($fontUrl)
    $fontFileName.replace('%20',' ')
    $localFontPath = Join-Path -Path $env:TEMP -ChildPath $fontFileName

    # Download the font
    Invoke-WebRequest -Uri $fontUrl -OutFile $localFontPath
    
    $ShellObject = New-Object -ComObject Shell.Application
    $Folder = $ShellObject.Namespace($FontCLSID)
    $Folder.CopyHere($localFontPath, 0x14) # 0x14 for silent overwrite



    ## Copy the font to the system font directory
    #Copy-Item -Path $localFontPath -Destination $fontsFolder -Force
    #
    ## Register the font with the system
    #Add-FontResource $localFontPath
    #Write-Host "Installed $fontFileName"
}

Write-Host "MesloLGS NF fonts have been installed."
