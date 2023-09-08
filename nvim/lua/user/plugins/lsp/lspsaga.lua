local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
	print("lspsage plugin not found")
	return
end

saga.setup({
	-- keybinds for navigation in lspsaga window
	move_in_sage = { prev = "<C-k>", next = "<C-j>" },
	scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
	finder_action_keys = { open = "<CR>" },
	definition_action_keys = { edit = "<CR>" },
	-- use enter to open file with definition preview
	definition = {
		edit = "<CR>",
	},
	ui = {
		colors = {
			normal_bg = "#022746",
		},
	},
})
