# Dotfiles

Personal configuration files (dotfiles) managed using
[Dotbot](https://github.com/anishathalye/dotbot).

## Install Dotfiles

Clone the repsitory, e.g. into `~/.dotfiles`:

```sh
git clone --recursive git@github.com:c-berger/dotfiles.git ~/.dotfiles
```

Run `install` script to generate symlinks:

On Linux:

```sh
~/.dotfiles/install
```

Or on Windows in PowerShell (as Administrator):

```ps
~/.dotfiles/install.ps1
```

From CMDER (requires gsudo installed already):

```
sudo powershell.exe -File install.ps1
```

## Additional Setup Required

In order to install all tools, the following software needs to be installed upfront:

### Install Scoop

TODO

### Install Tools via Scoop

### Setup Keypirinha

Install packet manager:

https://github.com/ueffel/Keypirinha-PackageControl

Open the `Keypirinha: Console` (Shortcut `F2`) and enter the following command:

```python
import keypirinha as kp,keypirinha_net as kpn,os;p="PackageControl.keypirinha-package";d=kpn.build_urllib_opener().open("https://github.com/ueffel/Keypirinha-PackageControl/releases/download/1.0.4/"+p);pb=d.read();d.close();f=open(os.path.join(kp.installed_package_dir(),p),"wb");f.write(pb);f.close()
```

After that, install the packages as defined in the
`keyphirinha/PackageControl.ini` file (maybe it installs automatically??):

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

TODO

Setup syncronization w/ OneDrive

Install the following plugins:

- Outline
- Rich Markdown
- Better Markdown Viewer
- Conflict Resolution
- Folding in Code Mirror Editor





