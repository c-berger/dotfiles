;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof
;= Add aliases below here
e.=explorer .
e=explorer $*
v=nvim $*
vi=nvim $*
vim=nvim $*
gv=nvim-qt $*
gvi=nvim-qt $*
gvim=nvim-qt $*
clear=cls
unalias=alias /d $1
editalias=nvim %CMDER_ROOT%\config\user_aliases.cmd & alias /reload
editprofile=nvim %CMDER_ROOT%\config\user_profile.cmd
cmderr=cd /d "%CMDER_ROOT%"
edit=notepad $*
calc=ipy -c "from math import *; print($*)"
ls=ls --show-control-chars -F --color $*
la=ls --show-control-chars -A -F --color $*
ll=ls --show-control-chars -al -F --color $*
lr=tree /F $*
cd~=cd "%USERPROFILE%\$*"
cdh=cd "%USERPROFILE%\$*"
cdc=cd "%USERPROFILE%\Documents\Coding\$*"
cdfw=cd "%USERPROFILE%\Documents\Coding\AFBR.S50.SDK\Firmware\$*"
cdae=cd "%USERPROFILE%\Documents\Coding\AFBR.S50.SDK\$*"
cdrf=cd "%USERPROFILE%\Documents\Coding\AFBR.S50.SDK\Sources\AFBR.Test\AFBR.Test.API.RF\$*"
cdut=cd "%USERPROFILE%\Documents\Coding\AFBR.S50.SDK\Firmware\Projects\UnitTest\$*"
cdez=cd "%USERPROFILE%\Documents\Coding\AFBR.S6.SDK\ezPyro_smd_to\$*"
gs=git status --short $*
gd=git diff $*
gds=git diff --staged $*
ga=git add $*
gc=git commit -m "$*"
gp=git push $*
gl=git log --oneline --all --graph --decorate  $*
serial=plink -serial \\.\COM$1 -sercfg $2,8,1,N,N $3 $4 $5 $6 $7 $8 $9
lp=pnputil /enum-devices /class Ports /connected | findstr "COM"
path=echo %path:;=&echo.%
err=echo %ERRORLEVEL%
robot=python -m robot $*
rebot=python -m rebot $*
pipupdateall=pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U
time=ptimer $*
docker=wsl docker $*
dc=C:\PortableApps\doublecmd\doublecmd.exe --no-splash --client -T -path $*
dcr=C:\PortableApps\doublecmd\doublecmd.exe --no-splash --client -T -P R -R $*
dcl=C:\PortableApps\doublecmd\doublecmd.exe --no-splash --client -T -P L -L $*
stree=C:\Users\chberger\AppData\Local\SourceTree\SourceTree.exe -f %CD% log
lg=lazygit $*
sudo=gsudo $*
