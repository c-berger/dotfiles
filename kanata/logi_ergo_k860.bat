@ECHO off

set KANATA=%USERPROFILE%\kanata\target\debug\kanata.exe

@REM requires kanata.exe in path
@REM %KANATA% --cfg %~dp0\logi_ergo_k860.kbd

@REM requires nircmd installed
@REM use `scoop install nircmd`
nircmd exec hide %KANATA% --cfg %~dp0\logi_ergo_k860.kbd
