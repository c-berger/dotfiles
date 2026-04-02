-- Integration CTRL-hjkl with Windows Terminal
-- by passing to the wt.exe command line.
--
-- Note: requires the AHK script .dotfiles/terminal/wt_navigation.ahk to run.
--------------------------------------------------------------------------------

-- Windows only...
if vim.fn.has("win32") ~= 1 and vim.fn.has("win64") ~= 1 then
  return
end

local config = {
  wt_executable = "wt",
  wt_window = "0",
  enable = {
    n = true, -- enabled in normal mode
    v = true, -- enabled in visual mode
    i = false, -- disabled in input mode
    t = true, -- enabled in terninal mode
  },
  keymap = {
    left = "<C-h>",
    down = "<C-j>",
    up = "<C-k>",
    right = "<C-l>",
  },
  -- pass throught for fzf and telescope
  pass_through_ft = { "fzf", "TelescopePrompt", "snacks_picker_input" },
}

local DIRECTION_TO_WINCMD = {
  left = "h",
  down = "j",
  up = "k",
  right = "l",
}

local function is_pass_through_ft(ft)
  if not config.pass_through_ft then
    return false
  end
  for value in ipairs(config.pass_through_ft) do
    if ft == value then
      return true
    end
  end
  return false
end

local function feedkeys_raw(mode, key)
  local codes = vim.api.nvim_replace_termcodes(key, true, true, true)
  vim.api.nvim_feedkeys(codes, mode, false)
end

local function navigate(direction)
  local wincmd_dir = DIRECTION_TO_WINCMD[direction]
  if not wincmd_dir then
    return
  end

  local cur_win = vim.api.nvim_get_current_win()
  local ok = pcall(vim.cmd, "wincmd " .. wincmd_dir)
  local new_win = vim.api.nvim_get_current_win()

  local focus_has_moved = new_win ~= cur_win
  if not ok or focus_has_moved then
    return
  end

  local cmd = { "wt", "move-focus", direction }
  if vim.system then
    vim.system(cmd, { detach = true })
  else
    vim.fn.jobstart(cmd, { detach = true })
  end
end

local function set_keymap(mode, dir, chord)
  vim.keymap.set(mode, chord, function()
    if is_pass_through_ft(vim.bo.filetype) then
      feedkeys_raw(mode, chord)
    else
      if mode == "t" then
        feedkeys_raw(mode, [[<C-\><C-N>]])
        vim.schedule(function()
          navigate(dir)
        end)
      else
        navigate(dir)
      end
    end
  end, { desc = "WT navigator " .. dir, silent = true })
end

for dir, chord in pairs(config.keymap) do
  vim.api.nvim_create_user_command("WtNavigate" .. dir:gsub("^%l", string.upper), function()
    navigate(dir)
  end, { desc = "WT navigator: " .. dir })

  if config.enable.n then
    set_keymap("n", dir, chord)
  end

  if config.enable.v then
    set_keymap("v", dir, chord)
  end

  if config.enable.i then
    set_keymap("i", dir, chord)
  end

  if config.enable.t then
    set_keymap("t", dir, chord)
  end
end

-- Write marker to communicate focussed state to AHK
local marker = vim.fn.expand("$TEMP/nvim_wt_focused")
local focus_grp = vim.api.nvim_create_augroup("WtNavigatorFocus", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "VimEnter" }, {
  group = focus_grp,
  callback = function()
    local f = io.open(marker, "w")
    if f then
      f:close()
    end
  end,
})

vim.api.nvim_create_autocmd({ "FocusLost", "VimLeave" }, {
  group = focus_grp,
  callback = function()
    os.remove(marker)
  end,
})

------------------------------------------------------
