-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--------------------------------------------------------------------------------

local keymap = vim.keymap
local function options(description)
  return { desc = description, noremap = true, silent = true, nowait = true }
end

-- general

-- do not copy character deleted with x
keymap.set("n", "x", '"_x', options("Delete character without clipboard"))

-- center cursor after jumping vertically
keymap.set("n", "<C-d>", "<C-d>zz", options("Center view after scrolling down."))
keymap.set("n", "<C-u>", "<C-u>zz", options("Center view after scolling up."))

-- quickfix next/previous
keymap.set("n", "<M-j>", "<cmd>cnext<CR>", options("Move to next quickfix entry."))
keymap.set("n", "<M-k>", "<cmd>cprev<CR>", options("Move to previous quickfix entry."))
