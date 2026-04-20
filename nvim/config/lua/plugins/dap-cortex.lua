-- Setup Cortex Debugging
-- ----------------------
-- NOTE: ensure cortex-debug is installed via Mason

return {
  "jedrzejboczar/nvim-dap-cortex-debug",
  dependencies = "mfussenegger/nvim-dap",

  config = function()
    require("dap-cortex-debug").setup({
      -- Optional: path to the extension if not using Mason default
      -- extension_path = vim.fn.stdpath("data") .. "/mason/packages/cortex-debug/extension",
      node_path = "node", -- ensure node is in your PATH
    })
  end,
}
