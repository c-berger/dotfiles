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

  -- 2. If not found upward, search downward into subfolders
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

    -- cwd must be the folder with project.yml, so ceedling also works from a subfolder
    local function ceedling_task(name, args)
      local root = find_ceedling_root()
      return {
        cmd = { "ceedling" },
        args = args,
        cwd = root,
        name = name,
        components = {
          "default",
          {
            "on_output_quickfix",
            open_on_exit = "failure",
            set_diagnostics = true,
            errorformat = ceedling_efm,
            relative_file_root = root,
          },
        },
      }
    end

    overseer.register_template({
      name = "Ceedling Test Current File",
      builder = function()
        local filename = vim.fn.expand("%:t:r")
        return ceedling_task("Ceedling: Test " .. filename, { "test:" .. filename })
      end,
      condition = {
        filetype = { "c", "cpp" }, -- Native static pruning
        callback = function()
          return vim.fn.expand("%:t"):match("^test_") ~= nil -- is test file "test_..."
            and find_ceedling_root() ~= nil -- is Ceedling root dir
        end,
      },
    })

    overseer.register_template({
      name = "Ceedling Test All",
      builder = function()
        return ceedling_task("Ceedling: Run All Tests", { "test:all" })
      end,
      condition = {
        filetype = { "c", "cpp" }, -- Native static pruning
        callback = function()
          return find_ceedling_root() ~= nil
        end,
      },
    })
  end,
}
