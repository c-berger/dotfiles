-- import codeium plugin safely
local status, codeium = pcall(require, "codeium")
if not status then
	print("Codeium plugin not found!")
	return
end

-- configure codeium
codeium.setup({})
