-- Codeium -- AI plugin
return {
    "Exafunction/codeium.nvim",
    build = ":Codeium Auth",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    opts = {}
}

