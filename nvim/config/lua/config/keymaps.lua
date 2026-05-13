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

-- Use ESC to clear different micromodes.
local function escape()
  -- Clear search highlighting
  vim.cmd("nohl")
  -- Clear diff mode
  vim.cmd("diffoff")
end
keymap.set("n", "<Esc>", escape, options("Clearing different micromodes."))
