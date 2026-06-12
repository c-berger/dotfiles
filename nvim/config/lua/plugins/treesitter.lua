return {
  "nvim-treesitter/nvim-treesitter",

  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, {
        "groovy", -- Add Groovy to Treesitter for syntax highlighting
      })
    end
  end,
}
