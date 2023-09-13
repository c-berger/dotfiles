-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	print("treesitter plugin not found")
	return
end

-- configure treesitter
treesitter.setup({
	-- enable syntax highlighting
	highlight = {
		enable = true,
	},
	-- enable indentation
	indent = { enable = true },
	-- ensure these language parsers are installed
	ensure_installed = {
		"bash",
		"c",
		"c_sharp",
		"cmake",
		"cpp",
		"css",
		"csv",
		"dockerfile",
		"doxygen",
		"git_config",
		"git_rebase",
		"gitattributes",
		"gitcommit",
		"gitignore",
		"gitignore",
		"groovy",
		"html",
		"ini",
		"json",
		"lua",
		"make",
		"markdown",
		"markdown_inline",
		"python",
		"regex",
		"robot",
		"vim",
		"xml",
		"yaml",
	},
	-- auto install above language parsers
	auto_install = true,
})
