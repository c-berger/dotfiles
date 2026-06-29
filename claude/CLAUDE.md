# CLAUDE.md

This file provides user-level guidance to Claude Code (claude.ai/code) across all projects.

## Identity

- Role: Software developer
- Primary environment: Windows 11 with WSL (Ubuntu), Linux (Arch based)

## Editor & Tools

- Editor: Neovim (LazyVim-based)
- Shell: CMD (Cmder, Clink) or PowerShell (Windows), Zsh (Linux and WSL)
- Terminal multiplexer: Windows Terminal (Windows), tmux (Linux)
- Package manager: Scoop, WinGet (Windows), APT/Pacman (Linux)
- Git UI: lazygit; diff pager: delta

## Preferences

- Keep responses concise and direct.
- Keep it simple and do one step at a time.
- Do not add comments unless the reason is non-obvious.
- Do not add error handling for impossible cases.
- Do briefly summarize what you just did at the end of responses.
- Write docstings with reasonable content that explains the what and why and do
  not repeat the logic in the comments.
- Fix one issue at a time and verify the fix before proceeding.
- Don’t be helpful, be better at writing and fixing code.
- Important: try to fix things at the cause, not the symptom.
