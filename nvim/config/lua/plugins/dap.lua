local dap = require("dap")

-- Track whether any session has ever launched so we know whether to
-- run_last() (relaunch) or prompt for a fresh configuration.
local has_launched = false
dap.listeners.after.event_initialized["dap_run_or_pause"] = function()
  has_launched = true
end

local function dap_run_or_pause()
  local session = dap.session()
  if session then
    if session.stopped_thread_id then
      dap.continue()
    else
      dap.pause()
    end
  elseif has_launched then
    dap.run_last()
  else
    dap.continue()
  end
end

return {
  {
    "mfussenegger/nvim-dap",

    keys = {
      -- stylua: ignore start
      { "<F5>", dap_run_or_pause, desc = "Run/Continue/Pause", },
      { "<C-F5>", function() dap.restart() end, desc = "Restart" },
      { "<F29>", function() dap.restart() end, desc = "Restart" }, -- <F29> == <C-F5>
      { "<C-S-F5>", function() dap.terminate() dap.run_last() end, desc = "Terminate and Relaunch" },
      { "<F41>", function() dap.terminate() dap.run_last() end, desc = "Terminate and Relaunch" }, -- <F41> == <C-S-F5>
      { "<F6>", function() dap.terminate() end, desc = "Terminate" },
      { "<F9>", function() dap.toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<C-F9>", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<C-S-F9>", function() dap.clear_breakpoints() end, desc = "Clear All Breakpoints" },
      { "<F45>", function() dap.clear_breakpoints() end, desc = "Clear All Breakpoints" },
      { "<C-F10>", function() dap.run_to_cursor() end, desc = "Run to Cursor" },
      { "<F34>", function() dap.run_to_cursor() end, desc = "Run to Cursor" },
      { "<F10>", function() dap.step_over() end, desc = "Step Over" },
      { "<F11>", function() dap.step_into() end, desc = "Step Into" },
      { "<S-F11>", function() dap.step_out() end, desc = "Step Out" },
      { "<F22>", function() dap.step_out() end, desc = "Step Out" },
      { "<C-F11>", function() dap.goto_() end, desc = "Go to Line (No Execute)" },
      { "<F35>", function() dap.goto_() end, desc = "Go to Line (No Execute)" },
      -- stylua: ignore end
    },
    opts = function()
      if not dap.adapters["codelldb"] then
        dap.adapters["codelldb"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "codelldb",
            args = {
              "--port",
              "${port}",
            },
          },
        }
      end

      -- Add Configurations for C and CPP
      for _, lang in ipairs({ "c", "cpp" }) do
        dap.configurations[lang] = {
          {
            name = "LLDB: Launch (CMake target)",
            type = "codelldb",
            request = "launch",
            program = function()
              return require("cmake-tools").get_launch_target_path()
            end,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        "cortex-debug",
        "pydebug",
      },
    },
    -- mason-nvim-dap is loaded when nvim-dap loads
    config = function() end,
  },
}
