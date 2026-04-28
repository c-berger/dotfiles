return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      win = {
        input = {
          keys = {
            ["<a-c>"] = { "toggle_cwd", mode = { "n", "i" } },
            ["<a-a>"] = { "toggle_hidden", mode = { "n", "i" } },
          },
        },
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>sf", function() Snacks.picker.files({ hidden = true, ignored = true }) end, desc = "All Files (Root Dir)" },
    { "<leader>sF", function() Snacks.picker.files({ hidden = true, ignored = true, root = false }) end, desc = "All Files (cwd)" },
    -- Grep
    { "<leader>sg", function() Snacks.picker.grep({ hidden = true, ignored = true }) end, desc = "Grep All Files (Root Dir)" },
    { "<leader>sG", function() Snacks.picker.grep({ hidden = true, ignored = true, root = false }) end, desc = "Grep All Files (cwd)" },
    -- search
    -- { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
  },
}
