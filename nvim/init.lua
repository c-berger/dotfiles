if vim.g.vscode then
    -- VSCode extension
    print("VSCode-NeoVim init")
else
    -- ordinary Neovim
    require("user.plugins")
    require("user.core.keymaps")
    require("user.core.options")
    require("user.core.colorscheme")
    require("user.plugins.comment")
    require("user.plugins.lualine")
    require("user.plugins.bufferline")
    require("user.plugins.which-key")
    require("user.plugins.gitsigns")
    require("user.plugins.nvim-tree")
    require("user.plugins.nvim-cmp")
    require("user.plugins.treesitter")
    require("user.plugins.lsp.mason")
    require("user.plugins.telescope")
    require("user.plugins.codeium")
    require("user.plugins.lsp.lspsaga")
    require("user.plugins.lsp.lspconfig")
    require("user.plugins.lsp.null-ls")
end
