-- import nvim-tree plugin safely
local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	print("Nvim-Tree plugin not found!")
	return
end

-- recommended settings from nvim-tree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- hjkl style navigation and editing
-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#h-j-k-l-style-navigation-and-editing
local api = require("nvim-tree.api")

local function edit_or_open()
	local node = api.tree.get_node_under_cursor()

	if node.nodes ~= nil then
		-- expand or collapse folder
		api.node.open.edit()
	else
		-- open file
		api.node.open.edit()
		-- Close the tree if file was opened
		-- api.tree.close()
	end
end

-- open as vsplit on current node
local function vsplit_preview()
	local node = api.tree.get_node_under_cursor()

	if node.nodes ~= nil then
		-- expand or collapse folder
		api.node.open.edit()
	else
		-- open file as vsplit
		api.node.open.vertical()
	end

	-- Finally refocus on tree if it was lost
	api.tree.focus()
end

-- on_attach callback
local function nvim_tree_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
	vim.keymap.set("n", "l", edit_or_open, opts("Edit Or Open"))
	vim.keymap.set("n", "L", vsplit_preview, opts("Vsplit Preview"))
	vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Collapse"))
	vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
end

-- configure nvim-tree
nvimtree.setup({
	-- register  on_attach callback
	on_attach = nvim_tree_on_attach,
	-- change folder arrow icons
	renderer = {
		icons = {
			glyphs = {
				folder = {
					arrow_closed = "", -- arrow when folder is closed
					arrow_open = "", -- arrow when folder is open
				},
			},
		},
	},
	-- disable window_picker for
	-- explorer to work well with
	-- window splits
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
	-- 	git = {
	-- 		ignore = false,
	-- 	},
})

-- open nvim-tree on setup
local function open_nvim_tree(data)
	-- buffer is a [No Name]
	local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

	-- buffer is a directory
	local directory = vim.fn.isdirectory(data.file) == 1

	if not no_name and not directory then
		return
	end

	-- change to the directory
	if directory then
		vim.cmd.cd(data.file)
	end

	-- open the tree
	require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
