; Integration of Neovim with Windows Terminal for pane switching via CTRL-hjkl
;
; Note: this only works in combination with .dotfiles/nvim/config/lua/config/wt_terminal.lua
; initialize in Neovim.
;
;
; This scipt will pass the CTRL-hjkl to Neovim if it is focussed such that Neovim
; can handle its own mappings and switch panes accordingly.
; Otherwise, the "wt" CLI command is used to switch panes in Windows Terminal.
;
; Neovim will set a marker file once it has focus.
; ------------------------------------------------------------------------------

#Requires AutoHotkey v2.0
#SingleInstance Force

; Path written by the Neovim plugin on FocusGained/VimEnter and deleted on FocusLost/VimLeave.
MarkerFile := A_Temp . "\nvim_wt_focused"

IsNvimFocused() => FileExist(MarkerFile) != ""
WtMove(dir) => Run("wt -w 0 move-focus " . dir,, "Hide")

; Only intercept when Windows Terminal is the foreground application.
#HotIf WinActive("ahk_exe WindowsTerminal.exe")

; $ prefix prevents AHK's own SendInput from re-triggering these hotkeys.
$^h:: IsNvimFocused() ? SendInput("^h") : WtMove("left")
$^j:: IsNvimFocused() ? SendInput("^j") : WtMove("down")
$^k:: IsNvimFocused() ? SendInput("^k") : WtMove("up")
$^l:: IsNvimFocused() ? SendInput("^l") : WtMove("right")

#HotIf
