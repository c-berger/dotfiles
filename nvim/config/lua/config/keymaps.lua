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
keymap.set("n", "<leader>rs", "<cmd>restart<CR>", options("Restart Neovim"))

-- do not copy character deleted with x
keymap.set("n", "x", '"_x', options("Delete character without clipboard"))

-- quickfix next/previous
local function safe_qf_next()
  if require("trouble").is_open() then
    require("trouble").next({ skip_groups = true, jump = true })
  else
    local success, _ = pcall(vim.cmd, "cnext")
    if not success then
      vim.cmd("cfirst")
    end
  end
end

local function safe_qf_prev()
  if require("trouble").is_open() then
    require("trouble").prev({ skip_groups = true, jump = true })
  else
    local success, _ = pcall(vim.cmd, "cprev")
    if not success then
      vim.cmd("clast")
    end
  end
end

keymap.set("n", "<M-j>", safe_qf_next, options("Move to next quickfix entry."))
keymap.set("n", "<M-k>", safe_qf_prev, options("Move to previous quickfix entry."))

-- terminal mode
keymap.set("t", "<Esc>", "<C-\\><C-n>", options("Map ESC in Terminal Mode"))

-- tab management
keymap.set("n", "<leader><tab><tab>", "<cmd>tabnext<CR>", options("Next Tab"))
keymap.set("n", "<leader><tab><S-tab>", "<cmd>tabnext<CR>", options("Previous Tab"))

-- Clear search and stop snippet on escape
keymap.set("n", "<esc>", function()
  vim.cmd("noh")
  vim.cmd("diffoff")
  LazyVim.cmp.actions.snippet_stop()
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch and diff" })
