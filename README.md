# Dotfiles

Personal configuration files (dotfiles) managed using
[Dotbot](https://github.com/anishathalye/dotbot).

## Install

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

## Update
