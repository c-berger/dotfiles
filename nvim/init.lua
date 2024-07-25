require("user.core.options")
require("user.core.keymaps")

if vim.g.vscode then
    -- VSCode extension
else
    -- ordinary Neovim
    require("user.core.plugins")
    require("user.core.colorscheme")
end
