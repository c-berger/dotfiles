return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      clangd = {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders=true",
          "--fallback-style=llvm",
          -- "--log=verbose",
          -- This allows clangd to query your ARM compiler for system include paths
          "--query-driver=C:/Users/{{USERNAME}}/scoop/apps/gcc-arm-none-eabi/current/bin/arm-none-eabi-gcc.exe",
        },
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>k", function() return vim.lsp.buf.hover() end, desc = "Hover" },
    { "<leader>m", vim.diagnostic.open_float, desc = "Line Diagnostics" },
  },
}
