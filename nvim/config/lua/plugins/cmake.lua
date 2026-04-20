return {
  "Civitasv/cmake-tools.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    cmake_generator = "Ninja",
    cmake_build_directory = "build",
  },
}
