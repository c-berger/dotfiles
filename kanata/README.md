# Kanata Keyboard Layout

The Kanata tool offers customization and extensions for any keyboard. This
defines some extensions based on the US international QWERTY layout. This is
basically a US QUERTY layout with some additional keys (e.g. the "102d" key).

## Setup

install Rust: `scoop install rust`
clone Kanata: `git clone ...`
build Kanata: `cargo build` (in kanata repo)
run Kanata: `target/debug/kanata.exe --cfg cfg_sample/minimal.kbd`


## Startup

Use `kanata.bat` to startup the `kanata.exe` in the background.

## Details

The folloging customizations are made:

### Caps-Lock as ESC/CTRL key

Caps-lock is remapped as ESC on tap and CTRL on hold.

### Menu Key

Due to a lack of the menu key (which comes handy if using keyboard in GUI applications),
the right CTRL key serves as a menu key on tap and CTRL on hold.

### Sticky Keys

Shift, Ctrl and Alt keys are sticky.

### Navigation Layer

Use `h`, `j`, `k`, `l` as arror keys (like in VIM).
Use `y`, `u`, `i`, `o` as `home`, `page-down`, `page-up`, `end` keys.

Activate via `f` key (tap-hold key feature).
Activate via `102d` key (the additional `\` key left of the `z` key.

### Numbers Layer

Use backtick/tilde to activate the layer.

## Erata

AltGr Issue: Kanata seems to not map AltGr correctly and it is not recognized by the
GUIs (e.g. Notepad++). Instead, it is recognized as CTRL+ALT. For example, using AltGr+u
to get ü will trigger the CTRL+ALT+u shortcut instead.

To resolve the issue, the AltGr layer needs to be rebuild in the keymap.

