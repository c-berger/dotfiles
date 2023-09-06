-- import lualine plugin safely
local status, lualine = pcall(require, "lualine")
if not status then
  print("Lualine plugin not found!")
  return
end

-- get lualine theme
local lualine_theme = require("lualine.themes.codedark")

-- configure lualine with modified theme
lualine.setup({
  options = {
    theme = lualine_theme,
  },
})
