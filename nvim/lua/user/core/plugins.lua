-- auto-install Lazy.nvim if not installed yet
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({{import = 'user.plugins'}}, {
    install = {
        missing = true,   -- install missing plugins on startup
    },
    change_detection = {
        enabled = true,  -- check for vonfig file changes
        notify = true,   -- get a notification when changes are found
    },
})
