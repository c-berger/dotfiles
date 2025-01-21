# Dotfiles

Personal configuration files (dotfiles) managed using
[Dotbot](https://github.com/anishathalye/dotbot).

## Setup on a new Windows machine

### First steps on a new Windows Machine

Use the following tool to debloat and configure Windows:
https://github.com/ChrisTitusTech/winutil

Execute in a PowerShell with administrator rights:

```powershell
Invoke-RestMethod "https://christitus.com/win" | Invoke-Expression
```

- Go to `Tweaks` and
    - Apply `Standard` configuration.
    - Customize (`Enable Dark Theme`, tweak task bar, etc.)
    - Add and activate the `Ultimate Performance Profile` in `Tweaks`
- Go to `Config` and install
    - `Hyper-V Virtualization`
    - `Windows Subsystem for Linux`
    - `Windows Sandbox`
    - `Enable OpenSSH Server`

Restart the PC.

### First time installation via Powershell

Run the installation script directly from powershell prompt via:

```powershell
Invoke-WebRequest https://raw.githubusercontent.com/c-berger/dotfiles/refs/heads/main/install.ps1 | Invoke-Expression
```

Note: if installing from a different branch then `main`, one needs to update the script accordingly!

### Setup SSH to access GitHub

- Enable OpenSSH Server via WinUtil as described above.
- Either setup existing SSH in `~/.ssh` or create a new one and setup on GitHub.
- Test via `ssh -T git@github.com`

### Install Dotfiles

Clone the repsitory, e.g. into `~/.dotfiles` and run the `install_files.ps1` script
(as administrator, e.g. via gsudo) to generate the symlinks:

```powershell
git clone --recursive git@github.com:c-berger/dotfiles.git $ENV:USERPROFILE\.dotfiles
cd $ENV:USERPROFILE\.dotfiles
sudo ./install_files.ps1
```

## Setup on a new Linux (Ubuntu) machine

### Install Tools via APT Package Manager

Download the `install_tools.sh` script from the repository and execute it from
bash:


```sh
curl -Lo install_tools.sh https://raw.githubusercontent.com/c-berger/dotfiles/main/install_tools.sh
chmod +x install_tools.sh
./install_tools.sh
```

### Install Dotfiles

Clone the repsitory, e.g. into `~/.dotfiles` and run the `install_files.sh` script to
generate the symlinks:

```sh
git clone --recursive git@github.com:c-berger/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install_files.sh
```

Note: if any config exists as regular file, it might be removed previously.


## Additional Steps to Setup Tools

### Setup Keypirinha

Install packet manager:

https://github.com/ueffel/Keypirinha-PackageControl

Open the `Keypirinha: Console` (Shortcut `F2`) and enter the following command:

```python
import keypirinha as kp,keypirinha_net as kpn,os;p="PackageControl.keypirinha-package";d=kpn.build_urllib_opener().open("https://github.com/ueffel/Keypirinha-PackageControl/releases/download/1.0.4/"+p);pb=d.read();d.close();f=open(os.path.join(kp.installed_package_dir(),p),"wb");f.write(pb);f.close()
```

After that, all packages should be installed (as defined in the
`keyphirinha/PackageControl.ini` file):

```ini
[main]
installed_packages =
    Keypirinha-WindowsApps
    keypirinha-cvt
    keypirinha-systemcommands
    Keypirinha-PackageControl
    Keypirinha-Plugin-Kill
    keypirinha-colorpicker
    keypirinha-terminal-profiles
    Keypirinha-Command
    Keypirinha-Dictionary
    keypirinha-symbols
```

### Setup Joplin

Setup syncronization w/ OneDrive

Install the following plugins:

- Outline
- Rich Markdown
- Better Markdown Viewer
- Conflict Resolution
- Folding in Code Mirror Editor
