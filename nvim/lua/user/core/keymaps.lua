vim.g.mapleader = " "

local keymap = vim.keymap
local options = {silent = true, noremap = true}

-- general

-- clear search highlighting
keymap.set("n", "<Leader>nh", ":nohl<CR>", options)

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
keymap.set("n", "<Leader>ve", ":edit $MYVIMRC<CR>", options) -- edit $MYVIMRC
-- keymap.set("n", "<Leader>vr", ":source $MYVIMRC<CR>", options) -- reload $MYVIMRC -- not working...

-- window management
keymap.set("n", "<Leader>sv", "<C-w>v", options) -- split window vertically
keymap.set("n", "<Leader>sh", "<C-w>s", options) -- split window horizontally
keymap.set("n", "<Leader>se", "<C-w>=", options) -- make split windows equal width & height
keymap.set("n", "<Leader>sx", ":close<CR>", options) -- close current split window

keymap.set("n", "<Leader>to", ":tabnew<CR>", options) -- open new tab
keymap.set("n", "<Leader>tx", ":tabclose<CR>", options) -- close current tab
keymap.set("n", "<Leader>tn", ":tabn<CR>", options) --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>", options) --  go to previous tab

-- buffers management
keymap.set("n", "<Leader><Tab>", ":bn<CR>", options) -- go to next buffer
keymap.set("n", "<Leader><S-Tab>", ":bp<CR>", options) -- go to previous buffer
keymap.set("n", "<Leader>bn", ":bn<CR>", options) -- go to next buffer
keymap.set("n", "<Leader>bp", ":bp<CR>", options) -- go to previous buffer
keymap.set("n", "<Leader>bx", ":bd<CR>", options) -- close current buffer

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", options) -- toggle split window maximization

-- comment
keymap.set("n", "<C-_>", "gcc", options) -- Comment/Uncomment source code w/ CTRL-/
keymap.set("v", "<C-_>", "gc", options)  -- Comment/Uncomment source code w/ CTRL-/

-- nvim-tree
keymap.set("n", "<Leader>e", ":NvimTreeToggle<CR>", options) -- toggle file explorer

-- telescope
keymap.set("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", options) -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", options) -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", options) -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", options) -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", options) -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", options) -- list available help tags

-- telescope git commands (not on youtube nvim video, options)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", options) -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", options) -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", options) -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", options) -- list current changes per file with diff preview ["gs" for git status]

