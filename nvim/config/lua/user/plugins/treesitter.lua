return {
    "nvim-treesitter/nvim-treesitter",
    build = ':TSUpdate',
    opts = {
        highlight = { enable = true, },
        indent = { enable = true },
        -- ensure these language parsers are installed
        ensure_installed = {
            "bash",
            "c",
            "c_sharp",
            "cmake",
            "cpp",
            "css",
            "csv",
            "diff",
            "dockerfile",
            "doxygen",
            "git_config",
            "git_rebase",
            "gitattributes",
            "gitcommit",
            "gitignore",
            "gitignore",
            "groovy",
            "html",
            "ini",
            "json",
            "lua",
            "luadoc",
            "make",
            "markdown",
            "markdown_inline",
            "python",
            "regex",
            "robot",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
        },
        -- auto install above language parsers
        auto_install = true,
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
}
