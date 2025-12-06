require("user.core.options")
require("user.core.keymaps")

if vim.g.vscode then
    -- VSCode extension
else
    -- ordinary Neovim
    require("user.core.plugins")

    -- colorscheme
    -- vim.o.background = "dark" -- or "light" for light mode
    -- vim.cmd([[colorscheme gruvbox-baby]])
    -- vim.cmd([[colorscheme gruvbox-baby]]) -- hack to properly load colorscheme
    vim.cmd([[colorscheme catppuccin-mocha]])
end
