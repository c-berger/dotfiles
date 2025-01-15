# Set required privileges and install Scoop
Set-ExecutionPolicy RemoteSigned -scope CurrentUser

# Install Scoop via installer script if not available.
if ((Get-Command "scoop.cmd" -ErrorAction SilentlyContinue) -eq $null)
{
    iwr -useb get.scoop.sh | iex
}

# Install Git (required for Scoop buckets)
scoop install git

# Add additional Scoop packages
scoop bucket add extras
scoop bucket add versions

# Install Tools
scoop install cmder ditto gsudo pyenv windows-terminal-preview
scoop install neovim lazygit delta zoxide doublecmd
scoop install keypirinha joplin-pre autohotkey everything-alpha

# Install Kanata from Source (to ~/kanata)
scoop install rust
pushd $HOME
git clone https://github.com/jtroo/kanata.git
cd kanata
cargo build
popd

# Install KMonad from Source (to ~/kmonad)
scoop install stack
pushd $HOME
git clone https://github.com/kmonad/kmonad.git
cd kmonad
stack build
stack install
popd

# Install and setup Python (via pyenv)
pyenv update
pyenv install 3.9.1
pyenv global 3.9.1
pyenv rehash
pip install --upgrade pip
pip install jupyterlab pandas matplotlib dominate pypandoc GitPython pyserial regex

# Note: this might require Visual Studio 2019 to correctly install pythonnet
# pip install robotframework pythonnet

pyenv rehash

# Set path to pyenv shims
$pyenvpath="$ENV:PYENV\shims"
$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path

$pyenvinpath = $oldpath.Contains($pyenvpath)
If (-not $pyenvinpath)
{
    echo "Add pyenv shims to path (at the beginning):"
    echo "$pyenvpath"

    $newpath="$pyenvpath;$oldpath"
    sudo Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newpath

    echo "Done: pyenv shims path successfully prepended..."
}

# IronPython w/ RobotFramework [not required any more (replaced by Python.Net)]
# scoop install %USERPROFILE%\Documents\ironpython.json
# ipy -m pip install robotframework
# alias robot=ipy -m robot $*
# alias rebot=ipy -m robot.rebot $*
