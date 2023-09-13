-- set colorscheme with protected call
-- local status, _ = pcall(vim.cmd, "colorscheme moonfly")
-- local status, _ = pcall(vim.cmd, "colorscheme nightfly")
-- local status, _ = pcall(vim.cmd, "colorscheme one-nvim")
-- local status, _ = pcall(vim.cmd, "colorscheme gruvbox")
local status, _ = pcall(vim.cmd, "colorscheme codedark")
-- local status, onedark = pcall(require, "onedark")
if not status then
	print("Colorscheme not found!") -- print error if colorscheme not installed
	return
end

-- onedark.setup { style = 'warm' }
-- onedark.load()

