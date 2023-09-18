vim.g.mapleader = " "

local keymap = vim.keymap
local options = { silent = true, noremap = true, nowait = true }

local function opts(description)
	return { desc = description, noremap = true, silent = true, nowait = true }
end

-- general

-- clear search highlighting
keymap.set("n", "<Leader>nh", ":nohl<CR>", opts("Clear search highlighting"))

-- do not copy character deleted with x
keymap.set("n", "x", '"_x', options)

-- re-select after indent/outdent
keymap.set("v", ">", ">gv", options)
keymap.set("v", "<", "<gv", options)

-- center cursor after jumping vertically
keymap.set("n", "]]", "]]zz", options)
keymap.set("n", "[[", "[[zz", options)
keymap.set("n", "[]", "[]zz", options)
keymap.set("n", "][", "][zz", options)
keymap.set("n", "<C-d>", "<C-d>zz", options)
keymap.set("n", "<C-u>", "<C-u>zz", options)

-- <leader>e to open file Explorer
-- keymap.set("n", "<Leader>e", ":E<CR>")

-- <leader>v to open .vimrc file
-- keymap.set("n", "<Leader>ve", ":edit $MYVIMRC<CR>", options) -- edit $MYVIMRC
-- keymap.set("n", "<Leader>vr", ":source $MYVIMRC<CR>", options) -- reload $MYVIMRC -- not working...

-- window management
keymap.set("n", "<Leader>sv", "<C-w>v", opts("Split Window Vertically"))
keymap.set("n", "<Leader>sh", "<C-w>s", opts("Split Window Horizontally"))
keymap.set("n", "<Leader>se", "<C-w>=", opts("Equal Split Window Sizes"))
keymap.set("n", "<Leader>sx", ":close<CR>", opts("Close Split Window"))

-- buffers management
keymap.set("n", "<Leader><Tab>", ":bn<CR>", opts("Next Buffer"))
keymap.set("n", "<Leader><S-Tab>", ":bp<CR>", opts("Previous Buffer"))
keymap.set("n", "L", ":bn<CR>", opts("Next Buffer"))
keymap.set("n", "H", ":bp<CR>", opts("Previous Buffer"))
keymap.set("n", "<Leader>x", ":Bdelete<CR>", opts("Close Buffer"))

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", opts("Split Window Maximize"))

-- comment
keymap.set("n", "<C-_>", "gcc", options) -- Comment/Uncomment source code w/ CTRL-/
keymap.set("v", "<C-_>", "gc", options) -- Comment/Uncomment source code w/ CTRL-/

-- nvim-tree
keymap.set("n", "<Leader>e", ":NvimTreeToggle<CR>", opts("Toggle Fle Explorer"))

-- telescope
keymap.set("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", opts("Find Files")) -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", opts("Find All Files")) -- find all files (including hidden) within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", opts("Find String in Files")) -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", opts("Find String Under Cursor")) -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts("Find Buffer")) -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts("Find Help Tags")) -- list available help tags

-- telescope git commands (not on youtube nvim video, options)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", opts("List All Git Commits (use <cr> to checkout)"))
keymap.set(
	"n",
	"<leader>gfc",
	"<cmd>Telescope git_bcommits<cr>",
	opts("List Git Commits For Current File/Buffer (use <cr> to checkout)")
)
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", opts("List Git Branches (use <cr> to checkout)"))
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", opts("List Current Changes Per File With Diff Preview"))
