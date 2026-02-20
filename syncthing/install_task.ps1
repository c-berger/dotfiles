# Creates and installs the syncthing windows task and runs it if it does not exist.
# Run as administrator!

$TaskName = "Syncthing"
$ActionPath = "C:\Users\chberger\scoop\shims\syncthing.exe"
$ActionArgument = "--no-console --no-browser"
$TimeDelay = New-TimeSpan -Minutes 1

# Check if the task already exists
$ExistingTask = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue

if ($null -eq $ExistingTask) {
    Write-Host "Task '$TaskName' not found. Creating..." -ForegroundColor Cyan

    $Action = New-ScheduledTaskAction -Execute $ActionPath -Argument $ActionArgument
    $Trigger = New-ScheduledTaskTrigger -AtLogOn -RandomDelay $TimeDelay
    #$Principal = New-ScheduledTaskPrincipal -UserId $currentUser -LogonType Interactive -RunLevel Limited
    Register-ScheduledTask -TaskName $TaskName -Action $Action -Trigger $Trigger # -Principal $Principal

    Start-ScheduledTask -TaskName $TaskName
    Write-Host "Task created and executed successfully." -ForegroundColor Green
} else {
    Write-Host "Task '$TaskName' already exists. No action taken." -ForegroundColor Yellow
}
