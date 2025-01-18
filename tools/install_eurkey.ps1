# Download and install latest EurKEY layout
# #########################################

# Define variables
$downloadUrl = "https://eurkey.steffen.bruentjen.eu/download/windows/1.3/eurkey13-beta.zip" # URL to the EurKEY layout zip file
$downloadPath = "$env:TEMP\eurkey.zip" # Temporary download path
$extractPath = "$env:TEMP\eurkey"      # Temporary extraction path

# Download the EurKEY zip file
Write-Output "Downloading EurKEY layout from $downloadUrl..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadPath

# Extract the zip file
Write-Output "Extracting EurKEY files to $extractPath..."
Expand-Archive -Path $downloadPath -DestinationPath $extractPath -Force

# Run the installer (requires administrative privileges)
$installerPath = Join-Path -Path $extractPath -ChildPath "eurkey_amd64.msi" # Adjust if the installer file is different
if (Test-Path $installerPath) {
    Write-Output "Running EurKEY installer..."
    Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", "`"$installerPath`"", "/quiet", "/norestart" -Verb RunAs -Wait
    Write-Output "EurKEY layout installed successfully."
} else {
    Write-Output "MSI file not found in extracted files. Please check the content of the downloaded package."
}

# Clean up
Write-Output "Cleaning up temporary files..."
Remove-Item -Path $downloadPath -Force
Remove-Item -Path $extractPath -Recurse -Force

# Reset Language and Keyboard Layout
# ##################################

$languageTag = "en-DE" # "2000"  # Language code (2000 = English (Germany), adjust if needed)
$keyboardLayout = "A0000409" # Layout code for EurKEY (adjust if necessary)
$inputMethodTips = "2000:A0000409" # Input Method for EurKEY with English (Germany)

# Add the keyboard layout to the current user's input methods
Write-Output "Reset to EurKEY layout to the current user's input methods..."
$languageList = New-WinUserLanguageList -Language $languageTag
$languageList[0].InputMethodTips.Clear() 
$languageList[0].InputMethodTips.Add($inputMethodTips) 
Set-WinUserLanguageList $languageList -Force

# Set the layout as the default input method
Write-Output "Setting EurKEY as the default input method..."
Set-WinUILanguageOverride -Language $languageTag
Set-WinDefaultInputMethodOverride -InputTip $keyboardLayout

# Confirm the changes
Write-Output "Verifying the active keyboard layout..."
Get-WinUserLanguageList

Write-Output "EurKEY layout has been added and activated."

