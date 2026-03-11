-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--------------------------------------------------------------------------------

-- Change behavior of the "Root Dir" versions to also use the current working
-- directory instead of the LSP root directory.
-- vim.g.root_spec = { "lsp", { "git", "lua" }, "cwd" }
vim.g.root_spec = { "git", "cwd" }

-- General options
vim.opt.shiftwidth = 4
