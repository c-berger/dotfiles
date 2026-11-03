# CLAUDE.md

User-level guidance for Claude Code across all projects.

## Environment

- Role: Software developer
- OS: Windows 11 with WSL (Ubuntu); Linux (Arch based)
- Editor: Neovim (LazyVim-based)
- Shell: CMD (Cmder, Clink) or PowerShell on Windows; Zsh on Linux and WSL
- Multiplexer: herdr or Windows Terminal (Windows); tmux (Linux)
- Package manager: Scoop or WinGet (Windows); APT or Pacman (Linux)
- Git: lazygit, delta as diff pager

## Communication

- Write to the user in simplified technical English (ASD-STE100): short
  sentences, simple words, one idea per sentence.
- Make things easy to digest. Do not add extra cognitive load. Keep responses
  short and direct.
- End each response with a brief summary of what you did.
- First understand every detail of the request. If something is unclear,
  ask the user until all details are clear. Do not guess.
- Interview the user relentlessly until you reach a shared understanding.

## Workflow

- Do one step at a time. Fix one issue, and verify the fix before the next.
- Fix the cause, not the symptom.
- Keep solutions simple. Do not add error handling for impossible cases.
- Do not try to be helpful. Be better at writing and fixing code.

## Git

- Never push to remote or create a PR unless the user asks.
- Ask the user to review before you commit.
- Write short commit messages. Add detail only when needed.

## Code Comments

- Add comments only when the reason is not obvious.
- Explain the why, not the what. Do not repeat the logic.
- Add comments on dismissed ideas or on non-obvious decisions.
