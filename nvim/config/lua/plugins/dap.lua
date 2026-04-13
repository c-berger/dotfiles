return {
  "mfussenegger/nvim-dap",

  -- stylua: ignore
  keys = {
    { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<C-F9>", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<C-S-F9>", function() require("dap").clear_breakpoints() end, desc = "Clear All Breakpoints" },
    { "<F5>", function() require("dap").continue() end, desc = "Run/Continue" },
    -- { "<S-F5>", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    -- { "<C-F5>", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    -- { "<leader>", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
    { "<S-F10>", function() require("dap").step_out() end, desc = "Step Out" },
    { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
    -- { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    -- { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    -- { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<F6>", function() require("dap").pause() end, desc = "Pause" },
    { "<S-F6>", function() require("dap").terminate() end, desc = "Terminate" },
  },
  -- stylua: ignore end

  opts = function()
    local dap = require("dap")

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
    if not dap.adapters["cppdbg"] then
      dap.adapters["cppdbg"] = {
        id = "cppdbg",
        type = "executable",
        -- install via `yay -S cpptools-debug`
        command = "/usr/share/cpptools-debug/bin/OpenDebugAD7",
      }
    end
    for _, lang in ipairs({ "c", "cpp" }) do
      dap.configurations[lang] = {
        {
          name = "Launch (CMake target) - cppdbg - " .. lang,
          type = "cppdbg",
          request = "launch",
          program = function()
            return require("cmake-tools").get_launch_target_path()
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = false,
          MIMode = "gdb",
          miDebuggerPath = "/usr/bin/gdb",
          setupCommands = {
            {
              text = "-enable-pretty-printing",
              description = "enable pretty printing",
              ignoreFailures = false,
            },
          },
        },
        {
          name = "Launch (CMake target) - codelldb - " .. lang,
          type = "codelldb",
          request = "launch",
          program = function()
            return require("cmake-tools").get_launch_target_path()
          end,
          cwd = "${workspaceFolder}",
        },
        {
          type = "codelldb",
          request = "launch",
          name = "Launch file - codelldb - " .. lang,
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
        },
        {
          type = "codelldb",
          request = "attach",
          name = "Attach to process - codelldb - " .. lang,
          pid = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end

    -- -- Auto-build before launching
    -- dap.listeners.before.launch.cmake_tools_integration = function()
    --   print("cmake-tools-integration before launch")
    --   local cmake = require("cmake-tools")
    --   cmake.build({})
    --   vim.wait(10000, function()
    --     return not cmake.is_building()
    --   end, 100)
    --   print("cmake-tools-integration build done")
    -- end
  end,
}
