return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
  },
  -- stylua: ignore
  keys = {
    { "<leader>k", function() return vim.lsp.buf.hover() end, desc = "Hover" },
    { "<leader>m", vim.diagnostic.open_float, desc = "Line Diagnostics" },
  },
}
