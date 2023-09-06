vim.g.mapleader = " "

local keymap = vim.keymap

-- general

-- clear search highlighting
keymap.set("n", "<Leader>nh", ":nohl<CR>")

-- do not copy character deleted with x
keymap.set("n", "x", '"_x')

-- re-select after indent/outdent
keymap.set("n", ">", ">gv")
keymap.set("n", "<", "<gv")

-- center cursor after jumping vertically
keymap.set("n", "]]", "]]zz")
keymap.set("n", "[[", "[[zz")
keymap.set("n", "[]", "[]zz")
keymap.set("n", "][", "][zz")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- <leader>e to open file Explorer
-- keymap.set("n", "<Leader>e", ":E<CR>")

-- <leader>v to open .vimrc file
keymap.set("n", "<Leader>v", ":e $MYVIMRC<CR>")

-- window management
keymap.set("n", "<Leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<Leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<Leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<Leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<Leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<Leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<Leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- buffers management
keymap.set("n", "<Leader><Tab>", ":bn<CR>") -- go to next buffer
keymap.set("n", "<Leader><S-Tab>", ":bp<CR>") -- go to previous buffer
keymap.set("n", "<Leader>bn", ":bn<CR>") -- go to next buffer
keymap.set("n", "<Leader>bp", ":bp<CR>") -- go to previous buffer
keymap.set("n", "<Leader>bx", ":bd<CR>") -- close current buffer

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- comment
keymap.set("n", "<C-_>", "gcc") -- Comment/Uncomment source code w/ CTRL-/
keymap.set("v", "<C-_>", "gc")  -- Comment/Uncomment source code w/ CTRL-/

-- nvim-tree
keymap.set("n", "<Leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- telescope
keymap.set("n", "<leader><leader>", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

