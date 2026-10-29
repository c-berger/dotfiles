-- Auto-start config
-- if you dont use UWSM add your auto start programs here, otherwise use XDG autostart https://wiki.archlinux.org/title/XDG_Autostart

hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd("noctalia")
	hl.exec_cmd("xhost +SI:localuser:root")
	hl.exec_cmd("syncthing")
	hl.exec_cmd(TERMINAL, { workspace = "1 silent" })
	hl.exec_cmd(BROWSER, { workspace = "2 silent" })
	hl.exec_cmd(FILE_MANAGER, { workspace = "3 silent" })
end)
