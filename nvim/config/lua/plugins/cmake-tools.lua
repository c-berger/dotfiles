return {
  "Civitasv/cmake-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "stevearc/overseer.nvim" },
  keys = {
    { "<F7>", "<cmd>CMakeBuild<CR>", desc = "Build using CMake" },
    { "<S-F7>", "<cmd>CMakeBuild!<CR>", desc = "Clean and Build using CMake" },
    { "<F19>", "<cmd>CMakeBuild!<CR>", desc = "Clean and Build using CMake" },
    { "<C-F7>", "<cmd>CMakeGenerate<CR>", desc = "Generate using CMake" },
    { "<F31>", "<cmd>CMakeGenerate<CR>", desc = "Generate using CMake" },
    { "<C-S-F7>", "<cmd>CMakeGenerate!<CR>", desc = "Clean and Generate using CMake" },
    { "<F43>", "<cmd>CMakeGenerate!<CR>", desc = "Clean and Generate using CMake" },
  },
  opts = {
    cmake_command = "cmake",
    cmake_generator = "Ninja",
    cmake_build_directory = "build",
    cmake_virtual_text_support = false, -- Don't show the target related to current file using virtual text (at right corner)
    cmake_executor = {
      name = "overseer",
      opts = {
        on_new_task = function(task)
          task:add_component({
            "on_output_quickfix",
            -- open = false,
            open_on_exit = "failure", -- Opens the view instantly if compiling fails
            set_diagnostics = true, -- Replicates compiler diagnostics to LSP styles
            -- relative_file_root = vim.fn.getcwd(), -- Force Ninja relative file paths to match project root boundaries
          })
        end,
      },
    },
    cmake_runner = { name = "overseer" },
  },
}
