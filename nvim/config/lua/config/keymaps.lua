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
keymap.set("n", "<C-d>", "<C-d>zz", options("center view after scrolling down"))
keymap.set("n", "<C-u>", "<C-u>zz", options("center view after scolling up"))
