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
})

local fzf_status, _ = pcall(telescope.load_extension("fzf"))
if not fzf_status then
	print("telescope fzf extension not found!")
	return
end
