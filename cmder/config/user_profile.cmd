:: use this file to run your own startup commands
:: use in front of the command to prevent printing the command

:: uncomment this to have the ssh agent load when cmder starts
:: call "%GIT_INSTALL_ROOT%/cmd/start-ssh-agent.cmd" /k exit

:: uncomment the next two lines to use pageant as the ssh authentication agent
:: SET SSH_AUTH_SOCK=/tmp/.ssh-pageant-auth-sock
:: call "%GIT_INSTALL_ROOT%/cmd/start-ssh-pageant.cmd"

:: you can add your plugins to the cmder path like so
:: set "PATH=%CMDER_ROOT%\vendor\whatever;%PATH%"

:: CMDER user bin path
:: set PATH=%PATH%;%CMDER_ROOT%\bin;

:: GIT Paths
set GIT_ROOT=%USERPROFILE%\scoop\apps\git\current
set PATH=%PATH%;%GIT_ROOT%\bin;
set PATH=%PATH%;%GIT_ROOT%\usr\bin;
set PATH=%PATH%;%GIT_ROOT%\usr\local\bin;

:: PYENV Path before MSYS Paths
:: >> already set in system environment path
::    but lets prepend to make sure the correct python is used
:: set PATH=%USERPROFILE%\.pyenv\pyenv-win\shims;%PATH%
:: set PATH=%USERPROFILE%\.pyenv\pyenv-win\bin;%PATH%

:: arguments in this batch are passed from init.bat, you can quickly parse them like so:
:: more useage can be seen by typing "cexec /?"

:: %ccall% "/customOption" "command/program"

:: set xterm for better usage with vim
set TERM=xterm-256color

@echo off
