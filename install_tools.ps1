Write-Host "Installing tools via install_tools.ps1 ..." -ForegroundColor Blue

Write-Host "Set required privileges for current user"
Set-ExecutionPolicy RemoteSigned -scope CurrentUser

# Install Scoop
if ($null -eq (Get-Command "scoop" -ErrorAction SilentlyContinue)) {
    Write-Host "Install and setup Scoop" -ForegroundColor Blue
    Invoke-WebRequest -UseBasicParsing get.scoop.sh | Invoke-Expression
    # Install Git (required for Scoop buckets)
    scoop install git
    # Add additional Scoop packages
    scoop bucket add extras
    scoop bucket add versions
}
else {
    Write-Host "Skip Scoop installation" -ForegroundColor DarkGray
}

# Install Tools via Scoop
Write-Host "Install Tools via Scoop" -ForegroundColor Blue
scoop install gsudo
scoop install eza                 # ls replacement and fork of exa; https://github.com/eza-community/eza
scoop install neovim
scoop install lazygit
scoop install delta
scoop install zoxide              # replacement for cd; https://github.com/ajeetdsouza/zoxide
scoop install ripgrep
scoop install gcc make cmake
scoop install cmder
scoop install doublecmd
scoop install ditto
scoop install speedcrunch
scoop install sumatrapdf
scoop install windows-terminal-preview
scoop install keypirinha
scoop install joplin
scoop install autohotkey
scoop install everything-alpha      # require alpha for version 1.5 to include dark mode
scoop install vscode                # sync settings with GitHub account!!
scoop install notepadplusplus

# Install Pyenv and Python
if ($null -eq (Get-Command "pyenv" -ErrorAction SilentlyContinue)) {
    Write-Host "Install and setup Python (via pyenv)" -ForegroundColor Blue
    Invoke-WebRequest "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" | Invoke-Expression
    
    # Reload Path for current process to enable pyenv and python executables.
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User) 
    $env:Path += ";"
    $env:Path += [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
    
    Write-Host "USER PATH: $([System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User))" -ForegroundColor Green
    Write-Host "MACH PATH: $([System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine))" -ForegroundColor Green
    Write-Host "PROC PATH: $([System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Process))" -ForegroundColor Green
    
    # Install and setup Python (via pyenv)
    pyenv update
    pyenv install 3.13.1
    pyenv global 3.13.1
    pyenv rehash
    pip install --upgrade pip
    pip install black clang-format
    # pip install jupyterlab pandas matplotlib dominate pypandoc GitPython pyserial regex
    
    # # Note: this might require Visual Studio 2019 to correctly install pythonnet
    # # pip install robotframework pythonnet
    # 
    pyenv rehash
}
else {
    Write-Host "Skip Pyenv/Python installation" -ForegroundColor DarkGray
}

# Install Ubuntu on WSL
wsl --install -d Ubuntu

Write-Host "Installed tools successfully!" -ForegroundColor Green
