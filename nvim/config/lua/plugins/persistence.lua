return {
  "folke/persistence.nvim",
  init = function()
    vim.api.nvim_create_autocmd("VimEnter", {
      group = vim.api.nvim_create_augroup("PersistenceAutoRestore", { clear = true }),
      callback = function()
        -- herdr/herdr-new-task.ps1 and herdr-resume.ps1 launch Neovim as
        -- `nvim .` so the tab opens at the right cwd; argc() is then 1, not
        -- 0, so also treat "the only arg is the cwd itself" as no-args.
        local no_args = vim.fn.argc() == 0
          or (vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1)
        if no_args and not vim.g.started_with_stdin then
          vim.schedule(function()
            require("persistence").load()
          end)
        end
      end,
    })
  end,
}
