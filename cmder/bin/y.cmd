@echo off

:: Use yazi to change directory.
::
:: Invoke `y` command to start yazi.
:: Use `q` to quit yazi and switch directory.
:: Use `Q` to quit yazi and don't switch directory.

set tmpfile=%TEMP%\yazi-cwd.%random%

yazi.exe %* --cwd-file="%tmpfile%"

if not exist "%tmpfile%" exit /b 0

set /p cwd=<"%tmpfile%"
if not "%cwd%"=="" if exist "%cwd%\" (
    cd /d "%cwd%"
)
del "%tmpfile%"
