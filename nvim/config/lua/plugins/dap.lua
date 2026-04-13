return {
  {
    "mfussenegger/nvim-dap",

    -- stylua: ignore
    keys = {
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<C-S-F9>", function() require("dap").clear_breakpoints() end, desc = "Clear All Breakpoints" },
      { "<F5>", function()
                  local dap = require("dap")
                  local status = dap.status()
                  if string.find(status, 'Stopped') then
                      dap.continue()
                  elseif status == '' then
                      dap.continue()
                  else
                      dap.pause()
                  end
               end, desc = "Run/Continue/Pause" },
      { "<C-F5>", function() require("dap").restart() end, desc = "Restart" },
      { "<C-S-F5>", function() require("dap").terminate() require("dap").run_last() end, desc = "Terminate and Relaunch" },
      { "<F6>", function() require("dap").terminate() end, desc = "Terminate" },
      { "<S-F5>", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
      { "<S-F11>", function() require("dap").step_out() end, desc = "Step Out" },
      { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },

      -- { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      -- { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      -- { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
      -- { "<leader>dr", function() require("dap").restart() end, desc = "Restart" },
      -- { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
      -- { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      -- { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      -- { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      -- { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      -- { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      -- { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      -- { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      -- { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      -- { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
      -- { "<leader>dR", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      -- { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      -- { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      -- { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },
}
