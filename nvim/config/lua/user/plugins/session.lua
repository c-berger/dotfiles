return {
    "rmagatti/auto-session",
    config = function()
        vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
        local keymap = vim.keymap
        local function opts(description)
            return { desc = description, noremap = true, silent = true, nowait = true }
        end

        keymap.set("n", "<leader>sl", "<cmd>SessionSearch<CR>", opts("[S]ession [L]ense"))
        keymap.set("n", "<leader>ss", "<cmd>SessionSave<CR>", opts("[S]ession [S]ave"))
        keymap.set("n", "<leader>sr", "<cmd>SessionRestore<CR>", opts("[S]ession [R]estore"))

        require("auto-session").setup({

            log_level = vim.log.levels.ERROR,
            suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },

            -- ⚠️ This will only work if Telescope.nvim is installed
            -- The following are already the default values, no need to provide them if these are already the settings you want.
            session_lens = {
                -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
                buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
                load_on_setup = true,
                theme_conf = { border = true },
                previewer = false,
            },

            pre_save_cmds = { "NvimTreeClose", "cclose", "helpclose" },
        })
    end,
}
