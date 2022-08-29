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
set PATH=%CMDER_ROOT%\bin;%PATH%

:: MSYS Paths
:: >> already set in system environment path
::    but lets prepend to make sure the MSYS tools are used
set MSYS_ROOT=%USERPROFILE%\scoop\apps\msys2\current
set PATH=%MSYS_ROOT%\opt\bin;%PATH%
set PATH=%MSYS_ROOT%\bin;%PATH%
set PATH=%MSYS_ROOT%\usr\bin;%PATH%
set PATH=%MSYS_ROOT%\usr\local\bin;%PATH%
:: set PATH=%PATH%;%MSYS_ROOT%\usr\bin\site_perl
:: set PATH=%PATH%;%MSYS_ROOT%\usr\bin\vendor_perl
:: set PATH=%PATH%;%MSYS_ROOT%\usr\bin\core_perl

:: PYENV Path before MSYS Paths
:: >> already set in system environment path
::    but lets prepend to make sure the correct python is used
set PATH=%USERPROFILE%\scoop\apps\pyenv\current\pyenv-win\shims;%PATH%

:: arguments in this batch are passed from init.bat, you can quickly parse them like so:
:: more useage can be seen by typing "cexec /?"

:: %ccall% "/customOption" "command/program"

:: set xterm for better usage with vim
set TERM=xterm-256color

@echo off
