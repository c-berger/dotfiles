# Dotfiles

Personal configuration files (dotfiles) managed using
[Dotbot](https://github.com/anishathalye/dotbot).

## Setup on a new Windows machine

### Prepare Powershell

Open powershell as adminstrator and run to allow script execution:

```powershell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
```

### Install Tools via Scoop

Download the `install_tools.ps1` script from the repository and execute it from
a new powershell (without administrator privileges):

```powershell
./install_tools.ps1
```

### Setup SSH to access GitHub

TODO

### Install Dotfiles

Clone the repsitory, e.g. into `~/.dotfiles` and run the `install.ps1` script
(as administrator, e.g. via gsudo) to generate the symlinks:

```powershell
git clone --recursive git@github.com:c-berger/dotfiles.git $ENV:USERPROFILE\.dotfiles
cd $ENV:USERPROFILE\.dotfiles
sudo ./install.ps1
```


## Setup on a new Linux (Ubuntu) machine

### Install Tools via APT Package Manager

Download the `install_tools.sh` script from the repository and execute it from
bash:


```sh
curl -Lo install_tools.sh https://raw.githubusercontent.com/c-berger/dotfiles/main/install_tools.sh
chmod +x install_tools.sh
sudo ./install_tools.sh
```

### Install Dotfiles

Clone the repsitory, e.g. into `~/.dotfiles` and run the `install` script to
generate the symlinks:

```sh
git clone --recursive git@github.com:c-berger/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
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
