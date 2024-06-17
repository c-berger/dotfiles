return {
	-- colorschemes
	"tomasiser/vim-code-dark",
	"Mofiqul/vscode.nvim",
	"bluz71/vim-nightfly-colors",
	"bluz71/vim-moonfly-colors",
	"Th3Whit3Wolf/one-nvim",
	"ellisonleao/gruvbox.nvim",
	"xiyaowong/transparent.nvim",
	"navarasu/onedark.nvim",

	"tpope/vim-repeat", -- fix "." for pluging mappings
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation
	"szw/vim-maximizer", -- maximizes and restores current window
	"tpope/vim-surround", -- add, delete, change surroundings (it's awesome)
	"inkarkat/vim-ReplaceWithRegister", -- replace with register contents using motion (gr + motion)
	"famiu/bufdelete.nvim", -- properly delete buffers without closing windows
    { "numToStr/Comment.nvim", opts = {}}, -- comment/uncomment


	-- managing & installing lsp servers, linters & formatters
	"williamboman/mason.nvim", -- in charge of managing lsp servers, linters & formatters
	"williamboman/mason-lspconfig.nvim", -- bridges gap b/w mason & lspconfig


	-- configuring lsp servers, linters and formatters
	"neovim/nvim-lspconfig", -- easily configure language servers
	"hrsh7th/cmp-nvim-lsp", -- for autocompletion
	"onsails/lspkind.nvim", -- vs-code like icons for autocompletion
	"kkharji/lspsaga.nvim", -- enhanced lsp uis

	-- formatting & linting
	"jose-elias-alvarez/null-ls.nvim", -- configure formatters & linters
	"jayp0521/mason-null-ls.nvim", -- bridges gap b/w mason & null-ls
}
