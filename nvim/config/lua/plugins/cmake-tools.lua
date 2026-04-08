return {
  "Civitasv/cmake-tools.nvim",
  keys = {
    { "<F7>", "<cmd>CMakeBuild<CR>", desc = "Build using CMake" },
    { "<S-F7>", "<cmd>CMakeBuild!<CR>", desc = "Clean and Build using CMake" },
    { "<C-F7>", "<cmd>CMakeGenerate<CR>", desc = "Generate using CMake" },
    { "<C-S-F7>", "<cmd>CMakeGenerate!<CR>", desc = "Clean and Generate using CMake" },
  },
  opts = {},
}
