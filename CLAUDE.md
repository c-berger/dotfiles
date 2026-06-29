# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles managed with [Dotbot](https://github.com/anishathalye/dotbot). Supports both Windows and Linux. Symlinks are defined in `install.conf.yaml` using the `dotbot-crossplatform` plugin for platform-conditional links.

## Installing Dotfiles (Symlinks)

**Windows (PowerShell, run as administrator):**

```powershell
sudo ./install_files.ps1
```

**Linux:**

```sh
./install_files.sh
```

Both scripts invoke Dotbot with `install.conf.yaml` and the
`dotbot-crossplatform` plugin. Run after cloning or adding new entries to
`install.conf.yaml`.

## Adding a New Config

1. Add the config files/folder under an appropriately named subdirectory.
2. Add a `crossplatform-link` entry in `install.conf.yaml` with the target path and `platform: win32` or `platform: linux`.
3. Re-run `install_files.ps1` / `install_files.sh` to create the symlink.

## Repository Structure

| Directory                          | Tool               | Notes                                                                                  |
| ---------------------------------- | ------------------ | -------------------------------------------------------------------------------------- |
| `nvim/config/`                     | Neovim             | LazyVim-based; linked to `~/AppData/Local/nvim` (Win) / `~/.config/nvim` (Linux)       |
| `vim/`                             | Vim                | `vimrc` (all), `vsvimrc` (VS Code Vim), `vrapperrc` (Vrapper)                          |
| `terminal/config/`                 | Windows Terminal   | Linked into the Store app's LocalState folder                                          |
| `psmux/config/`                    | psmux              | tmux-like multiplexer for Windows; config follows tmux syntax                          |
| `tmux/`                            | tmux               | Linux only                                                                             |
| `bash/` / `zsh/`                   | Bash / Zsh         | Linux only; includes aliases and fzf integration                                       |
| `git/`                             | Git                | Separate `gitconfig_windows` and `gitconfig_linux`; `gitconfig_private` holds identity |
| `lazygit/`                         | lazygit            | Linked to `~/AppData/Roaming/lazygit` (Win) / `~/.config/lazygit` (Linux)              |
| `hyprland/`                        | Hyprland WM        | Linux only; includes hypridle, hyprlock, waybar portal config                          |
| `waybar/` / `wlogout/` / `clipse/` | Hyprland stack     | Linux only                                                                             |
| `keypirinha/`                      | Keypirinha         | Windows launcher; `user/` for settings, `installed_packages/` for packages             |
| `kanata/` / `kmonad/`              | Keyboard remappers | Windows; startup scripts in `kanata_start.bat` / `kmonad_start.bat`                    |
| `notepad++/`                       | Notepad++          | Linked to `~/AppData/Roaming/Notepad++`                                                |
| `doublecmd/`                       | Double Commander   | Separate `settings_windows/` and `settings_linux/`                                     |
| `ditto/`                           | Ditto clipboard    | Windows; `Ditto.Settings` linked into Scoop install dir                                |
| `yazi/`                            | Yazi               | Linked on both platforms                                                               |
| `bat/`                             | bat                | Linux only                                                                             |
| `vifm/`                            | Vifm               | Linux only; `vifm/colors` is a git submodule                                           |
| `cmder/`                           | Cmder              | Windows; config and bin linked into Scoop persist dir                                  |
| `ghostty/`                         | Ghostty            | Linux only                                                                             |
| `scoop/`                           | Scoop              | Windows package manager config                                                         |
| `ahk/`                             | AutoHotKey         | `wt_navigation.ahk` auto-starts on login                                               |
| `everything/`                      | Everything search  | Windows; ini copied (not linked) due to app overwrite behavior                         |

## Neovim Config Architecture

Based on [LazyVim](https://lazyvim.github.io). Entry point: `nvim/config/init.lua`.

Custom configuration lives in `nvim/config/lua/`:

- `config/` — options, keymaps, autocmds, lazy bootstrap, filetype definitions
- `plugins/` — one file per plugin override/addition

Notable plugins configured:

- `lsp.lua` — LSP server setup
- `cmake-tools.lua` — CMake integration
- `dap.lua`, `dap-cortex.lua`, `dap-python.lua` — DAP debugging
- `avante.lua` — AI coding assistant
- `oil.lua` — file manager inside Neovim
- `format.lua`, `lint.lua` — formatting and linting

## Cross-Tool Navigation Integration

Ctrl-hjkl pane navigation is wired across three layers:

- `ahk/wt_navigation.ahk` — AutoHotKey script (auto-starts on login) intercepts Ctrl-hjkl in Windows Terminal; checks marker files to know if Neovim or tmux/psmux has focus, then either passes the key through to the editor or switches terminal panes.
- `nvim/config/lua/config/wt_navigation.lua` — Neovim side; writes the marker files AHK reads to detect focus.
- `psmux/config/psmux.conf` / `tmux/tmux.conf` — tmux-side vim-aware navigation via `vim-tmux-navigator` pattern.

When modifying any pane-navigation behavior, all three layers need to be considered together.

## Git Submodules

- `dotbot/` — Dotbot itself
- `dotbot-crossplatform/` — crossplatform link plugin
- `vifm/colors` (at `vifm/colors/`) — Vifm color schemes

After cloning, initialize with:

```sh
git submodule update --init --recursive
```
