-- Setup Python Debugging
-- ----------------------
-- NOTE: ensure pydebug is installed via Mason

return {
  "mfussenegger/nvim-dap-python",

  config = function()
    -- Configure 'debugpy as installed by Mason
    -- Common path for Mason: vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
    -- Note: on Windows it must use pythonw to not pawn an empty console window!
    local python_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/Scripts/pythonw.exe"
    require("dap-python").setup(python_path)

  end,
}
