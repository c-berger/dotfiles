-- Sets CTRL-hjkl to move focus in Windows Terminal
-- by invoking the wt.exe command.
--

local function move_wt_focus(direction)
	os.execute("wt.exe move-focus " .. direction)
end

function move_left()
	move_wt_focus("left")
end
function move_down()
	move_wt_focus("down")
end
function move_up()
	move_wt_focus("up")
end
function move_right()
	move_wt_focus("right")
end

-- Note: CTRL-h is equivalent to Backspace. Thus, we need to set
-- terminal.differentiate_keys = true in clink_settings for this to work.
rl.setbinding([["\e[27;5;72~"]], [["luafunc:move_left"]])
rl.setbinding([["\C-J"]], [["luafunc:move_down"]])
rl.setbinding([["\C-K"]], [["luafunc:move_up"]])
rl.setbinding([["\C-L"]], [["luafunc:move_right"]])
