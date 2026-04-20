-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--------------------------------------------------------------------------------

local keymap = vim.keymap
local function options(description)
  return { desc = description, noremap = true, silent = true, nowait = true }
end

require("config.wt_navigation")

-- general
keymap.set("n", "<leader>rs", '<cmd>restart lua require("persistence").load()<CR>', options("Restart Neovim"))

-- do not copy character deleted with x
keymap.set("n", "x", '"_x', options("Delete character without clipboard"))

-- center cursor after jumping vertically
keymap.set("n", "<C-d>", "<C-d>zz", options("Center view after scrolling down."))
keymap.set("n", "<C-u>", "<C-u>zz", options("Center view after scolling up."))
keymap.set("n", "]]", "]]zz", options("Center view after scrolling."))
keymap.set("n", "[[", "[[zz", options("Center view after scrolling."))
keymap.set("n", "[]", "[]zz", options("Center view after scrolling."))
keymap.set("n", "][", "][zz", options("Center view after scrolling."))
keymap.set("n", "}", "}zz", options("Center view after scrolling."))
keymap.set("n", "{", "{zz", options("Center view after scrolling."))

-- quickfix next/previous
keymap.set("n", "<M-j>", "<cmd>cnext<CR>", options("Move to next quickfix entry."))
keymap.set("n", "<M-k>", "<cmd>cprev<CR>", options("Move to previous quickfix entry."))

-- terminal mode
keymap.set("t", "<Esc>", "<C-\\><C-n>", options("Map ESC in Terminal Mode"))

-- tab management
keymap.set("n", "<leader><tab><tab>", "<cmd>tabnext<CR>", options("Next Tab"))
keymap.set("n", "<leader><tab><S-tab>", "<cmd>tabnext<CR>", options("Previous Tab"))
