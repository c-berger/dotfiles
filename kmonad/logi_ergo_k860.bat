@ECHO off


@REM kmonad.exe %~dp0\logi_ergo_k860.kbd

@REM requires nircmd installed
@REM use `scoop install nircmd`
nircmd exec hide kmonad.exe %~dp0\logi_ergo_k860.kbd
