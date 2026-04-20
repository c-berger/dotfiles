return {
  "Civitasv/cmake-tools.nvim",
  keys = {
    { "<F7>", "<cmd>CMakeBuild<CR>", desc = "Build using CMake" },
    { "<S-F7>", "<cmd>CMakeBuild!<CR>", desc = "Clean and Build using CMake" },
    { "<F19>", "<cmd>CMakeBuild!<CR>", desc = "Clean and Build using CMake" },
    { "<C-F7>", "<cmd>CMakeGenerate<CR>", desc = "Generate using CMake" },
    { "<F31>", "<cmd>CMakeGenerate<CR>", desc = "Generate using CMake" },
    { "<C-S-F7>", "<cmd>CMakeGenerate!<CR>", desc = "Clean and Generate using CMake" },
    { "<F43>", "<cmd>CMakeGenerate!<CR>", desc = "Clean and Generate using CMake" },
  },
  opts = {},
}
