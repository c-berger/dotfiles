#!/usr/bin/env bash
# Write or remove %TEMP%\tmux_wt_focused so the AHK wt_navigation script knows
# Tmux has focus and should pass Ctrl-hjkl through rather than calling wt move-focus.
#
# Called from tmux hooks (client-focus-in/out, client-attached/detached).
# Only does anything inside WSL, where cmd.exe resolves the Windows %TEMP% path.

grep -qi microsoft /proc/version 2>/dev/null || exit 0

WIN_TEMP=$(/mnt/c/Windows/System32/cmd.exe /C 'echo %TEMP%' 2>/dev/null | tr -d '\r')
WIN_TEMP_UNIX=$(wslpath "$WIN_TEMP" 2>/dev/null) || exit 0
MARKER="$WIN_TEMP_UNIX/tmux_wt_focused"

case "$1" in
  on)  touch "$MARKER" ;;
  off) rm -f "$MARKER" ;;
esac
