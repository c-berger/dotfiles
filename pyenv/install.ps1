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

