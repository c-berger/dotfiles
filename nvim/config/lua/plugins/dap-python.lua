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

    -- -- Custom debug configuration (this overwrites the default configurations
    -- require("dap").configurations.python = {
    --   {
    --     type = "python",
    --     request = "launch",
    --     name = "Launch file",
    --     program = "${file}",
    --     console = "internalConsole", -- ✅ no popup window
    --     pythonPath = function()
    --       -- important: use pythonw version on Wondows too avoid spawning of an empty console window
    --       return vim.fn.getcwd() .. "/.venv/Scripts/pythonw.exe"
    --     end,
    --   },
    -- }
  end,
}
