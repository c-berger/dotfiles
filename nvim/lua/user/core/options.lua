local opt = vim.opt -- for conciseness

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- mouse
opt.mouse = "a"

-- undo history
opt.undofile = true

-- line numbers
opt.relativenumber = true
opt.number = true
opt.ruler = true

-- tabs & indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search / replace
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.inccommand = 'split' -- preview substitute

-- cursor
opt.cursorline = true
opt.scrolloff = 5

-- appearance
opt.showmode = false
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- whitespace
opt.listchars = "tab:|->,trail:~,extends:…,precedes:…,space:·"
opt.list = true

-- backspace
opt.backspace = "indent,eol,start"

-- word boundries
opt.iskeyword:append("-") -- add "-" as word character

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- Create a virtualenv specifically for Nvim using pyenv, and set `g:python3_host_prog`.  This will avoid the need to install the pynvim module in each version/virtualenv.
vim.g.python_host_prog = '~/.pynvim_env/bin/python'
vim.g.python3_host_prog = '~/.pynvim_env/bin/python'
