return {
  "mason-org/mason-lspconfig.nvim",

  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, {
        "groovyls", -- Add Groovy
        "npm-groovy-lint",
      })
    end
  end,
}
