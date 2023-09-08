local status, null_ls = pcall(require, "null-ls")
if not status then
	print("null-ls plugin not found!")
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

-- enable keybinds only for when null-ls available
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- set keybinds
	vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
end

-- to setup format on save
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	on_attach = on_attach,
	sources = {
		formatting.prettier,
		formatting.stylua,
		formatting.clang_format,
		diagnostics.cpplint,
	},
	-- configure format on save
	-- on_attach = function(current_client, bufnr)
	--     if current_client.supports_method("textDocument/formatting") then
	--         vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	--         vim.api.nvim_create_autocmd("BufWritePre", {
	--             group = augroup,
	--             buffer = bufnr,
	--             callback = function()
	--                 vim.lsp.buf.format({
	--                     filter = function(client)
	--                         --  only use null-ls for formatting instead of lsp server
	--                         return client.name == "null-ls"
	--                     end,
	--                     bufnr = bufnr,
	--                 })
	--             end,
	--         })
	--     end
	-- end,
})
