local saga_status, lspsaga = pcall(require, "lspsaga")
if not saga_status then
	print("lspsage plugin not found")
	return
end

-- saga.setup({
-- 	-- keybinds for navigation in lspsaga window
-- 	move_in_sage = { prev = "<C-k>", next = "<C-j>" },
-- 	scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
-- 	finder_action_keys = { open = "<CR>" },
-- 	definition_action_keys = { edit = "<CR>" },
-- 	-- use enter to open file with definition preview
-- 	definition = {
-- 		edit = "<CR>",
-- 	},
-- 	ui = {
-- 		colors = {
-- 			normal_bg = "#022746",
-- 		},
-- 	},
-- })

lspsaga.setup({ -- defaults ...
	debug = false,
	use_saga_diagnostic_sign = true,
	-- diagnostic sign
	error_sign = "",
	warn_sign = "",
	hint_sign = "",
	infor_sign = "",
	diagnostic_header_icon = "   ",
	-- code action title icon
	code_action_icon = " ",
	code_action_prompt = {
		enable = true,
		sign = true,
		sign_priority = 40,
		virtual_text = true,
	},
	finder_definition_icon = "  ",
	finder_reference_icon = "  ",
	max_preview_lines = 10,
	finder_action_keys = {
		open = "o",
		vsplit = "s",
		split = "i",
		quit = "q",
		scroll_down = "<C-f>",
		scroll_up = "<C-b>",
	},
	code_action_keys = {
		quit = "q",
		exec = "<CR>",
	},
	rename_action_keys = {
		quit = "<C-c>",
		exec = "<CR>",
	},
	definition_preview_icon = "  ",
	border_style = "single",
	rename_prompt_prefix = "➤",
	rename_output_qflist = {
		enable = false,
		auto_open_qflist = false,
	},
	server_filetype_map = {},
	diagnostic_prefix_format = "%d. ",
	diagnostic_message_format = "%m %c",
	highlight_prefix = false,
})
