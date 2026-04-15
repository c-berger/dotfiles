local dap = require("dap")

local function dap_run_or_pause()
  local status = dap.status()
  if string.find(status, "Stopped") or status == "" then
    dap.continue()
  else
    dap.pause()
  end
end

return {
  {
    "mfussenegger/nvim-dap",

    keys = {
      -- stylua: ignore start
      { "<F5>", dap_run_or_pause, desc = "Run/Continue/Pause", },
      { "<C-F5>", function() dap.restart() end, desc = "Restart" },
      { "<C-S-F5>", function() dap.terminate() dap.run_last() end, desc = "Terminate and Relaunch" },
      { "<F6>", function() dap.terminate() end, desc = "Terminate" },
      { "<F9>", function() dap.toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<C-S-F9>", function() dap.clear_breakpoints() end, desc = "Clear All Breakpoints" },
      { "<C-F10>", function() dap.run_to_cursor() end, desc = "Run to Cursor" },
      { "<F10>", function() dap.step_over() end, desc = "Step Over" },
      { "<F11>", function() dap.step_into() end, desc = "Step Into" },
      { "<S-F11>", function() dap.step_out() end, desc = "Step Out" },
      { "<C-F11>", function() dap.goto_() end, desc = "Go to Line (No Execute)" },

      -- { "<leader>dB", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      -- { "<leader>db", function() dap.toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      -- { "<leader>dc", function() dap.continue() end, desc = "Run/Continue" },
      -- { "<leader>dr", function() dap.restart() end, desc = "Restart" },
      -- { "<leader>da", function() dap.continue({ before = get_args }) end, desc = "Run with Args" },
      -- { "<leader>dC", function() dap.run_to_cursor() end, desc = "Run to Cursor" },
      -- { "<leader>dg", function() dap.goto_() end, desc = "Go to Line (No Execute)" },
      -- { "<leader>di", function() dap.step_into() end, desc = "Step Into" },
      -- { "<leader>dj", function() dap.down() end, desc = "Down" },
      -- { "<leader>dk", function() dap.up() end, desc = "Up" },
      -- { "<leader>dl", function() dap.run_last() end, desc = "Run Last" },
      -- { "<leader>do", function() dap.step_out() end, desc = "Step Out" },
      -- { "<leader>dO", function() dap.step_over() end, desc = "Step Over" },
      -- { "<leader>dP", function() dap.pause() end, desc = "Pause" },
      -- { "<leader>dR", function() dap.repl.toggle() end, desc = "Toggle REPL" },
      -- { "<leader>ds", function() dap.session() end, desc = "Session" },
      -- { "<leader>dt", function() dap.terminate() end, desc = "Terminate" },
      -- { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
      -- stylua: ignore end
    },

    -- config = function()
    --   -- load mason-nvim-dap here, after all adapters have been setup
    --   if LazyVim.has("mason-nvim-dap.nvim") then
    --     require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
    --   end
    --
    --   vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
    --
    --   for name, sign in pairs(LazyVim.config.icons.dap) do
    --     sign = type(sign) == "table" and sign or { sign }
    --     vim.fn.sign_define(
    --       "Dap" .. name,
    --       { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
    --     )
    --   end
    --
    --   -- setup dap config by VsCode launch.json file
    --   local vscode = require("dap.ext.vscode")
    --   local json = require("plenary.json")
    --   vscode.json_decode = function(str)
    --     return vim.json.decode(json.json_strip_comments(str))
    --   end
    -- end,
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
