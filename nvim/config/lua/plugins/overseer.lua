-- Helper function to restart last overseer task
local function restart_last_task()
  local overseer = require("overseer")
  local tasks = overseer.list_tasks({ unique = true })
  if #tasks > 0 then
    overseer.run_action(tasks[1], "restart")
  else
    vim.notify("No overseer tasks found to restart", vim.log.levels.WARN)
  end
end

-- Helper function to find project.yml in the current workspace or subfolders
local function find_ceedling_root()
  -- 1. Check if it's in the current working directory or upward
  local root_match = vim.fs.find("project.yml", { upward = true, path = vim.fn.getcwd() })
  if #root_match > 0 then
    return vim.fs.dirname(root_match[1])
  end

  -- 2. If not found upward, search downward into subfolders (max depth 3 to keep it fast)
  local sub_match = vim.fs.find("project.yml", { limit = 1, type = "file", path = vim.fn.getcwd() })
  if #sub_match > 0 then
    return vim.fs.dirname(sub_match[1])
  end

  return nil
end

-- error format string to parse ceedling output for failed tests
local ceedling_efm = table.concat({
  [=[%-P[%f]]=], -- push filename to stack
  [=[%A  Test: %m]=], -- start new error message of unspecified type
  [=[%Z  At line (%l): "%m"]=], -- end error message
  [=[%-Q]=], -- pop filename from stack
  [=[%-G%.%#]=], -- ignore other stuff
}, ",")

return {
  "stevearc/overseer.nvim",
    -- stylua: ignore
  keys = {
    { "<leader>or", restart_last_task, desc = "Restart Last Task" },
  },

  opts = function(_, opts)
    local overseer = require("overseer")

    -- Template: Ceedling Test Current File
    overseer.register_template({
      name = "Ceedling Test Current File",
      builder = function()
        local ceedling_dir = find_ceedling_root()
        local filename = vim.fn.expand("%:t:r")
        print("ceedling test:" .. filename .. " - cwd: " .. ceedling_dir)
        return {
          cmd = { "ceedling" },
          args = { "test:" .. filename },
          cwd = ceedling_dir, -- Ensures ceedling runs in the subfolder containing project.yml
          name = "Ceedling: Test " .. filename,
          components = {
            "default",
            {
              "on_output_quickfix",
              -- open = false,
              open_on_exit = "failure",
              set_diagnostics = true,
              errorformat = ceedling_efm,
              relative_file_root = ceedling_dir,
            },
          },
        }
      end,
      condition = {
        filetype = { "c", "cpp" }, -- Native static pruning
        callback = function()
          local has_ceedling = find_ceedling_root() ~= nil
          local is_test_file = vim.fn.expand("%:t"):match("^test_") ~= nil
          if is_test_file then
            print("ceedling is test file: " .. vim.fn.expand("%:t"))
          else
            print("ceedling is not test file: " .. vim.fn.expand("%:t"))
          end
          return has_ceedling and is_test_file
        end,
      },
    })

    -- Template: Ceedling Run All Tests
    overseer.register_template({
      name = "Ceedling Test All",
      builder = function()
        local ceedling_dir = find_ceedling_root()
        return {
          cmd = { "ceedling" },
          args = { "test:all" },
          cwd = ceedling_dir, -- Ensures ceedling runs in the subfolder containing project.yml
          name = "Ceedling: Run All Tests",
          components = {
            "default",
            {
              "on_output_quickfix",
              -- open = false,
              open_on_exit = "failure",
              set_diagnostics = true,
              errorformat = ceedling_efm,
              relative_file_root = ceedling_dir,
            },
          },
        }
      end,
      condition = {
        filetype = { "c", "cpp" }, -- Native static pruning
        callback = function()
          local root = find_ceedling_root()
          print("ceedling root: " .. root)
          return find_ceedling_root() ~= nil
        end,
      },
    })
  end,
}
