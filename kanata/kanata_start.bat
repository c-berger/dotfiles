
@SET KANATA=%USERPROFILE%\kanata\target\debug\kanata.exe
@SET CONFIG=%~pd0\config.kbd
@SET LOGFLE=%~pd0\kanata.log

@REM Kill any existing process before starting a new one.
taskkill /f /im kanata.exe

@REM Execute Kanata in background and set priority to realtime.
nircmd execmd "%KANATA% --trace --cfg %CONFIG% > %LOGFLE% 2>&1"
nircmd setprocesspriority kanata.exe realtime
