# 1. Render the interactive fzf menu overlay
$choice = @(
    "WSL (Ubuntu)"
    "PowerShell Core (pwsh)"
    "Cmder (cmd)"
) | fzf --header="Select profile:"

# If the user cancels out of fzf, exit quietly without splitting
if (-not $choice) { exit }

# Initialize variable as null
$clearCmd = $null
$targetCmd = $null

# 2. Determine the correct executable payload based on the selection
switch -Wildcard ($choice) {
    "*WSL*"   { 
        $targetCmd = "wsl.exe -d Ubuntu"
        $clearCmd  = "clear" 
    }
    "*pwsh*"  { 
        $targetCmd = "pwsh.exe -NoExit -Command Clear-Host" 
    }
    "*Cmder*" { 
        # $targetCmd = "$env:USERPROFILE\.dotfiles\cmder\cmder-shell.cmd"
        # $clearCmd  = "cls"
    }
    Default   { exit }
}

# 3. Create a new pane split and capture Herdr's structural JSON output
$splitJson = herdr pane split --direction right

# 4. Extract the unique pane ID from the JSON
$newPaneId = ($splitJson | ConvertFrom-Json).result.pane.pane_id

# 5. Immediately override and run the targeted shell inside that pane
if ($targetCmd) {
    herdr pane run $newPaneId $targetCmd
}

# 6. If a specific separate clear command was defined, execute it
if ($clearCmd) {
    # Give the shell layout a split second to catch up before running the clear string
    Start-Sleep -Milliseconds 150
    herdr pane run $newPaneId $clearCmd
}

# 7. Shift user keyboard focus to the newly created shell pane
herdr pane focus --direction right
