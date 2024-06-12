-- auto-install Lazy.nvim if not installed yet
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]])

return require("lazy").setup({

	-- colorschemes
	"tomasiser/vim-code-dark",
	"Mofiqul/vscode.nvim",
	"bluz71/vim-nightfly-colors",
	"bluz71/vim-moonfly-colors",
	"Th3Whit3Wolf/one-nvim",
	"ellisonleao/gruvbox.nvim",
	"xiyaowong/transparent.nvim",
	"navarasu/onedark.nvim",

	-- essential plugins
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use
	"tpope/vim-repeat", -- fix "." for pluging mappings
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation
	"szw/vim-maximizer", -- maximizes and restores current window
	"tpope/vim-surround", -- add, delete, change surroundings (it's awesome)
	"inkarkat/vim-ReplaceWithRegister", -- replace with register contents using motion (gr + motion)
	"numToStr/Comment.nvim", -- comment/uncomment
	"famiu/bufdelete.nvim", -- properly delete buffers without closing windows
	"folke/which-key.nvim", -- popup for keybindins

	-- file explorer
	"nvim-tree/nvim-tree.lua",

	-- vs-code like icons
	"nvim-tree/nvim-web-devicons",

	-- statusline / bufferline
	"nvim-lualine/lualine.nvim",
	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },

	-- fuzzy finding w/ telescope
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- dependency for better sorting performance
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { { "nvim-lua/plenary.nvim" } } }, -- fuzzy finder

	-- autocompletion
	"hrsh7th/nvim-cmp", -- completion plugin
	"hrsh7th/cmp-buffer", -- source for text in buffer
	"hrsh7th/cmp-path", -- source for file system paths

	-- snippets
	"L3MON4D3/LuaSnip", -- snippet engine
	"saadparwaiz1/cmp_luasnip", -- for autocompletion
	"rafamadriz/friendly-snippets", -- useful snippets

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

	-- treesitter configuration
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			local ts_update = dependencies("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	},

	-- git integratiotagn
	"lewis6991/gitsigns.nvim", -- show line modifications on left hand side

	-- Codeium
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
	}, -- AI plugin by codeium
})

