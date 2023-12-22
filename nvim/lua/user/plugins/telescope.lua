-- import telescope plugin safely
local telescope_status, telescope = pcall(require, "telescope")
if not telescope_status then
	print("Telescope plugin not found!")
	return
end

-- import telescope actions safely
local actions_status, actions = pcall(require, "telescope.actions")
if not actions_status then
	print("Telescope.actions not found!")
	return
end

-- configure telescope
telescope.setup({
	-- configure custom mappings
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous, -- move to prev result
				["<C-j>"] = actions.move_selection_next, -- move to next result
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
			},
		},
	},
	-- You dont need to set any of these options. These are the default ones. Only
	-- the loading is important
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
local fzf_status, _ = pcall(telescope.load_extension("fzf"))
-- if not fzf_status then
-- 	print("telescope fzf extension not found!")
-- 	return
-- end
