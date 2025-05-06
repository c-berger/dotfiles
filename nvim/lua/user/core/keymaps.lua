local keymap = vim.keymap
local options = { silent = true, noremap = true, nowait = true }

local function opts(description)
    return { desc = description, noremap = true, silent = true, nowait = true }
end

-- general

-- clear search highlighting
keymap.set("n", "<Esc>", ":nohl<CR>", opts("Clear Search Highlighting"))

-- do not copy character deleted with x
keymap.set("n", "x", '"_x', options)

-- re-select after indent/outdent
keymap.set("v", ">", ">gv", options)
keymap.set("v", "<", "<gv", options)

-- center cursor after jumping vertically
keymap.set("n", "}", "}zz", options)
keymap.set("n", "{", "{zz", options)
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
keymap.set("n", "<Leader>sv", "<C-w>v", opts("[S]plit Window [V]ertically"))
keymap.set("n", "<Leader>sh", "<C-w>s", opts("[S]plit Window [H]orizontally"))
keymap.set("n", "<Leader>se", "<C-w>=", opts("[S]plit Window [E]qualize Size"))
keymap.set("n", "<Leader>sx", ":close<CR>", opts("[S]plit Window Close [X]"))
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", opts("[S]plit Window [M]aximize")) -- vim-maximizer

-- buffers management
keymap.set("n", "<Leader><Tab>", ":bn<CR>", opts("Next Buffer"))
keymap.set("n", "<Leader><S-Tab>", ":bp<CR>", opts("Previous Buffer"))
keymap.set("n", "L", ":bn<CR>", opts("Next Buffer"))
keymap.set("n", "H", ":bp<CR>", opts("Previous Buffer"))
keymap.set("n", "<Leader>x", ":Bdelete<CR>", opts("Close Buffer [X]"))

-- diff files
keymap.set("n", "<Leader>de", ":diffthis<CR>", opts("[D]iff [E]nable for current file"))
keymap.set("n", "<Leader>dd", ":diffoff<CR>", opts("[D]iff [D]isable for current file"))

-- terminal mode
keymap.set("t", "<Esc>", "<C-\\><C-n>", opts("Map ESC in Terminal Mode"))

-- navigation
keymap.set("t", "<C-h>", "<C-\\><C-n>:TmuxNavigateLeft<CR>", opts("Navigate left in Terminal Mode"))
keymap.set("t", "<C-j>", "<C-\\><C-n>:TmuxNavigateDown<CR>", opts("Navigate down in Terminal Mode"))
keymap.set("t", "<C-k>", "<C-\\><C-n>:TmuxNavigateUp<CR>", opts("Navigate up in Terminal Mode"))
keymap.set("t", "<C-l>", "<C-\\><C-n>:TmuxNavigateRight<CR>", opts("Navigate right in Terminal Mode"))
keymap.set("i", "<C-h>", "<ESC>:TmuxNavigateLeft<CR>", opts("Navigate left in Terminal Mode"))
keymap.set("i", "<C-j>", "<ESC>:TmuxNavigateDown<CR>", opts("Navigate down in Terminal Mode"))
keymap.set("i", "<C-k>", "<ESC>:TmuxNavigateUp<CR>", opts("Navigate up in Terminal Mode"))
keymap.set("i", "<C-l>", "<ESC>:TmuxNavigateRight<CR>", opts("Navigate right in Terminal Mode"))

-- quickfix list
keymap.set("n", "<Leader>qo", ":copen<CR>", opts("[Q]uickfix [O]pen"))
keymap.set("n", "<Leader>qq", ":cclose<CR>", opts("[Q]uickfix [Q]uit"))
keymap.set("n", "<Leader>qn", ":cnext<CR>", opts("[Q]uickfix [N]ext"))
keymap.set("n", "<Leader>qp", ":cprev<CR>", opts("[Q]uickfix [P]revious"))
keymap.set("n", "<M-j>", ":cnext<CR>", opts("Quickfix Next"))
keymap.set("n", "<M-k>", ":cprev<CR>", opts("Quickfix Previous"))

-- comment
keymap.set("n", "<C-_>", "gcc", options) -- Comment/Uncomment source code w/ CTRL-/
keymap.set("v", "<C-_>", "gc", options)  -- Comment/Uncomment source code w/ CTRL-/

----------------------
-- Autocommands
----------------------

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

----------------------
-- Plugin Keybinds
----------------------

-- nvim-tree
keymap.set("n", "<Leader>e", ":NvimTreeToggle<CR>", opts("Toggle File [E]xplorer"))

----------------------
-- VSCode Specific
----------------------
if vim.g.vscode then
    -- unmap gq which defaults to `format_line`
    -- https://github.com/vscode-neovim/vscode-neovim/issues/1874#issuecomment-2085259808
    keymap.set("n", "gq", "gq", { noremap = true })
    keymap.set("n", "gqq", "gqq", { noremap = true })
    keymap.set("v", "gq", "gq", { noremap = true })
end
