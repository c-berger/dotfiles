-- set colorscheme with protected call
-- local status, _ = pcall(vim.cmd, "colorscheme moonfly")
local status, _ = pcall(vim.cmd, "colorscheme codedark")
if not status then
  print("Colorscheme not found!") -- print error if colorscheme not installed
  return
end
