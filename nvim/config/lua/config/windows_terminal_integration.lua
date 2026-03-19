-- Integration CTRL-hjkl with Windows Terminal by
-- passing to the wt.exe command line.
--------------------------------------------------------------------------------

if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
  local keymap = vim.keymap
  local function options(description)
    return { desc = description, noremap = true, silent = true, nowait = true }
  end

  local function smart_move(key, direction)
    local current_win = vim.api.nvim_get_current_win()
    vim.cmd("wincmd " .. key)
    local focus_has_not_moved = vim.api.nvim_get_current_win() == current_win
    if focus_has_not_moved then
      os.execute("wt.exe move-focus " .. direction)
    end
  end

  -- Map Ctrl+hjkl and Ctrl+l
  keymap.set("n", "<C-h>", function()
    smart_move("h", "left")
  end, options("Moves cursor to left window or passes to windows terminal"))
  keymap.set("n", "<C-j>", function()
    smart_move("l", "down")
  end, options("Moves cursor to lower window or passes to windows terminal"))
  keymap.set("n", "<C-h>", function()
    smart_move("h", "up")
  end, options("Moves cursor to upper window or passes to windows terminal"))
  keymap.set("n", "<C-l>", function()
    smart_move("l", "right")
  end, options("Moves cursor to right window or passes to windows terminal"))
end
