# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles for Windows and Linux. [Dotbot](https://github.com/anishathalye/dotbot) creates the symlinks. All links are in `install.conf.yaml`. The `dotbot-crossplatform` plugin sets the platform (`win32` or `linux`) for each link.

## Install

Run after you clone the repo or add a link to `install.conf.yaml`.

```powershell
sudo ./install_files.ps1   # Windows, as administrator
```

```sh
./install_files.sh         # Linux
```

Tools are installed with `install_tools.ps1` (Windows) and `install_tools.sh` (Linux).

After you clone, load the submodules (`dotbot/`, `dotbot-crossplatform/`, `vifm/colors/`):

```sh
git submodule update --init --recursive
```

## Add a New Config

1. Put the files in a new folder, for example `tool/config/`.
2. Add a `crossplatform-link` entry to `install.conf.yaml`.
3. Run the install script again.

## Layout

One folder per tool. Most folders are linked to the config path of the tool. See `install.conf.yaml` for the targets.

Special cases:

- `git/` — separate `gitconfig_windows` and `gitconfig_linux`. `gitconfig_private` holds the identity.
- `claude/` — `CLAUDE.md`, `commands/` and `skills/` are linked to `~/.claude/`.
- `herdr/config/` — `config_windows.toml` and `config_linux.toml` are linked to the herdr config. `commands/` is linked to `~/AppData/Roaming/herdr/commands` (Windows).
- `doublecmd/` — separate `settings_windows/` and `settings_linux/`.
- `everything/` — the ini file is copied, not linked. The app overwrites links.
- `opencode/` — the whole folder is linked. The app replaces single file links.
- Linux only: `bash/`, `zsh/`, `tmux/`, `hyprland/`, `waybar/`, `wlogout/`, `clipse/`, `bat/`, `vifm/`, `ghostty/`, `kitty/`, `noctalia/`.
- Windows only: `keypirinha/`, `kanata/`, `kmonad/`, `ditto/`, `cmder/`, `scoop/`, `winget/`, `terminal/`.

Kept for reference only. Do not delete, and do not link:

- `psmux/` — replaced by `herdr/`.
- `ahk/wt_navigation.ahk` and `nvim/config/lua/config/wt_navigation.lua` — the old Windows Terminal and psmux navigation.

## Neovim

LazyVim-based. Entry point: `nvim/config/init.lua`. Custom code is in `nvim/config/lua/`:

- `config/` — options, keymaps, autocmds, lazy bootstrap, filetypes.
- `plugins/` — one file per plugin change or addition.

`plugins/persistence.lua` loads the last session on `VimEnter` when you start `nvim` with no file arguments. This includes `nvim .`. The herdr task scripts rely on this.

## Pane Navigation (Ctrl-hjkl)

Three parts work together. If you change one, check the other two.

- `ahk/herdr_navigation.ahk` — starts on login. It reads marker files to see if Neovim or a herdr pane has focus. Then it sends the key to Neovim or calls the `herdr` CLI.
- `nvim/config/lua/config/herdr_navigation.lua` — writes the marker files.
- `herdr/config/config_windows.toml` `[keys]` — herdr key bindings. This includes the `ctrl+shift+...` resize keys. Windows Terminal does not support them, so AHK also handles them.
