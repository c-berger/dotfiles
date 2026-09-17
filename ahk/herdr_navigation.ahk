; Integration of Neovim with Herdr for pane switching via CTRL-hjkl
;
; Note: this only works in combination with .dotfiles/nvim/config/lua/config/herdr_navigation.lua
; initialize in Neovim.
;
; Herdr runs full-screen inside a single Windows Terminal window/tab (its own
; focus_pane_left/down/up/right keys are left commented out in herdr's
; config.toml so Ctrl-hjkl reaches Neovim first).
;
; This script will pass the CTRL-hjkl to Neovim if it is focussed such that Neovim
; can handle its own mappings and switch panes accordingly.
; Otherwise, the "herdr" CLI is used to switch panes directly.
;
; Neovim will set a marker file once it has focus.
; ------------------------------------------------------------------------------

#Requires AutoHotkey v2.0
#SingleInstance Force

; Path written by the Neovim plugin on FocusGained/VimEnter and deleted on FocusLost/VimLeave.
MarkerFile     := A_Temp . "\nvim_is_focused"
; Path written by the Tmux hooks (tmux/wt_marker.sh) when Tmux has focus in a WSL pane.
TmuxMarkerFile := A_Temp . "\tmux_is_focused"

IsNvimFocused()  => FileExist(MarkerFile) != ""
IsTmuxFocused()  => FileExist(TmuxMarkerFile) != ""
IsPassThrough()  => IsNvimFocused() || IsTmuxFocused()
HerdrMove(dir)   => Run("herdr pane focus --direction " . dir,, "Hide")
WtTabNext()      => Run("wt -w 0 focus-tab --next",, "Hide")
WtTabPrevious()  => Run("wt -w 0 focus-tab --previous",, "Hide")

; Only intercept when Windows Terminal is the foreground application.
#HotIf WinActive("ahk_exe WindowsTerminal.exe")

; $ prefix prevents AHK's own SendInput from re-triggering these hotkeys.
; CTRL+hjkl
$^h:: IsPassThrough() ? SendInput("^h") : HerdrMove("left")
$^j:: IsPassThrough() ? SendInput("^j") : HerdrMove("down")
$^k:: IsPassThrough() ? SendInput("^k") : HerdrMove("up")
$^l:: IsPassThrough() ? SendInput("^l") : HerdrMove("right")
; ALT+hl (fallback for nested WSL/tmux tabs; herdr itself already owns alt+h/l
; for its own tab switching when a herdr pane, not tmux, is focused)
; $!h:: IsTmuxFocused() ? SendInput("!h") : WtTabPrevious()
; $!l:: IsTmuxFocused() ? SendInput("!l") : WtTabNext()

#HotIf
