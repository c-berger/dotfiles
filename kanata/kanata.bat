@ECHO off

set KANATA=%USERPROFILE%\kanata\target\debug\kanata.exe

@REM requires kanata.exe in path
@REM %KANATA% --cfg %~dp0\config.kbd

@REM requires nircmd installed
@REM use `scoop install nircmd`
nircmd exec hide %KANATA% --cfg %~dp0\config.kbd

@SET KANATA=%USERPROFILE%\kanata\target\debug\kanata.exe
@SET CONFIG=%~pd0\config.kbd
@SET LOGFLE=%~pd0\kanata.log

@REM Kill any existing process before starting a new one.
@REM taskkill /f /im kanata.exe

@REM Execute Kanata in background and set priority to realtime.
@REM nircmd execmd "%KANATA% --trace --cfg %CONFIG% > %LOGFLE% 2>&1"
@REM nircmd setprocesspriority kanata.exe realtime

%KANATA% --trace --cfg %CONFIG% > %LOGFLE% 2>&1
