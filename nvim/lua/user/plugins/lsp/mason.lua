-- import nvim-cmp plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
	print("Mason plugin not found!")
	return
end

-- import luasnip plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	print("mason-lspconfig plugin not found!")
	return
end

-- import luasnip plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	print("mason-null-ls plugin not found!")
	return
end

mason.setup()

mason_lspconfig.setup({
	ensure_installed = {
		-- list of servers for mason to install
		-- see: https://github.com/williamboman/mason-lspconfig.nvim
		"bashls", -- Bash
		"clangd", -- C/C++
		-- "csharp_ls", "omnisharp", "omnisharp_mono", -- C#
		"cmake", -- CMake
		-- "dockerls", -- Docker
		"lua_ls", -- Lua
		"marksman", -- Markdown
		"pyright", -- Python
		-- ...
	},
	-- auto-install configured servers (with lspconfig)
	automatic_installation = true,
})

mason_null_ls.setup({
	ensure_installed = {
		-- formatters
		"prettier",
		"stylua",
		"clang-format",
		"cmakelang",
		"black",
		-- linters
		"cpplint",
		"cmakelang",
		"cmakelint",
		"flake8",
	},
	automatic_installation = true,
})
