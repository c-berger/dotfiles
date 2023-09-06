local opt = vim.opt -- for conciseness

-- mouse
opt.mouse = "a"

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

-- search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- cursor
opt.cursorline = true
opt.scrolloff = 5

-- appearance
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


