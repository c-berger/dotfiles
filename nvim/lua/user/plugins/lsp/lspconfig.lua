-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	print("lspconfig plugin not found")
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	print("cmp_nvim_lsp plugin not found")
	return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	local function opts(description)
		return { desc = description, noremap = true, silent = true, buffer = buffnr, nowait = true }
	end

	-- set keybinds
	keymap.set("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts("show definition, references"))
	keymap.set("n", "gD", vim.lsp.buf.declaration, opts("got to declaration"))
	keymap.set("n", "gd", vim.lsp.buf.definition, opts("got to definition"))
	-- keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts("see definition and make edits in window"))
	keymap.set("n", "gi", vim.lsp.buf.implementation, opts("go to implementation"))
	keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<CR>", opts("see available code actions"))
	keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", opts("smart rename"))
	keymap.set("n", "<leader>lD", "<cmd>Lspsaga show_line_diagnostics<CR>", opts("show  diagnostics for line"))
	keymap.set("n", "<leader>ld", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts("show diagnostics for cursor"))
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts("jump to previous diagnostic in buffer"))
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts("jump to next diagnostic in buffer"))
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts("show documentation for what is under cursor"))
	keymap.set("n", "<leader>lo", "<cmd>LSoutlineToggle<CR>", opts("see outline on right hand side"))
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure c/c++ server
lspconfig["clangd"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = {
		"clangd",
		"--offset-encoding=utf-16",
	},
})

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

lspconfig["pyright"].setup({
	capabilities = capabilities,
})

lspconfig["cmake"].setup({
	capabilities = capabilities,
})
