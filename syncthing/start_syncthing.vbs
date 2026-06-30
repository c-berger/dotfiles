' Use this to start syncthing without spawning a terminal window through the task scheduler.
CreateObject("WScript.Shell").Run """C:\Users\chberger\scoop\shims\syncthing.exe"" --no-console --no-browser", 0, False
