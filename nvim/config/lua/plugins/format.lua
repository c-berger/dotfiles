return {
  {
    "stevearc/conform.nvim",
    opts = {
      log_level = vim.log.levels.DEBUG,
      default_format_opts = {
        timeout_ms = 5000,
      },
      formatters_by_ft = {
        groovy = { "groovy_fmt" },
      },
      formatters = {
        groovy_fmt = {
          command = "npm-groovy-lint",
          args = { "--fix", "-" },
          stdin = true,
          exit_codes = { 0, 1 },
        },
      },
    },
  },
}
