
@SET KANATA=%USERPROFILE%\kanata\target\debug\kanata.exe
@SET CONFIG=%~pd0\config.kbd
@SET LOGFLE=%~pd0\kanata.log

nircmd execmd "%KANATA% --trace --cfg %CONFIG% > %LOGFLE% 2>&1"
nircmd setprocesspriority kanata.exe realtime
