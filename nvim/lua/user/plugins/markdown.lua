return {
    "OXY2DEV/markview.nvim",
    lazy = false, -- recommended
    -- ft = "markdown",

    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        modes = { "n", "c" },
        hybrid_modes = { "i" },
        code_blocks = {
            enable = true,
            style = "language",
            pad_amount = 0,
            pad_char = " ",
        },
        headings = {
            enable = true,
            shift_width = 1,
        },
    },
}
