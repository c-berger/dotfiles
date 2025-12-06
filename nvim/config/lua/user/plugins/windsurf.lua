-- Windsurf (Codeium) -- AI plugin
return {
    "Exafunction/windsurf.nvim",
    -- build = ":Codeium Auth",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("codeium").setup({
        })
    end
}
