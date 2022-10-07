nircmd execmd "kmonad.exe --log-level debug %~dp0\config.kbd > %~dp0\kmonad.log 2>&1"
nircmd setprocesspriority kmonad.exe realtime

