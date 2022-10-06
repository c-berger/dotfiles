@ECHO off


@REM kmonad.exe %~dp0\config.kbd

@REM requires nircmd installed
@REM use `scoop install nircmd`
nircmd exec hide kmonad.exe %~dp0\config.kbd
