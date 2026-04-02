return {
  "stevearc/oil.nvim",
  keys = {
    { "-", "<cmd>Oil --float<CR>", desc = "Open Oil.Nvim" },
  },
  opts = {
    float = {
      padding = 5,
      border = "bold",
    },
    keymaps = {
      ["q"] = { "actions.close", mode = "n" },
    },
    view_options = {
      show_hidden = true,
    },
  },
  -- Optional dependencies
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
