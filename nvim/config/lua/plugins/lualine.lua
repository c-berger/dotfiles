return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections.lualine_c[4] = {
        -- Update path to show up to 5 elements of file path
        LazyVim.lualine.pretty_path({ length = 5 }),
      }
    end,
  },
}
