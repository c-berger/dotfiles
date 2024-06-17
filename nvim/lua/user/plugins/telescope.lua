-- Fuzzy Finder (files, lsp, etc)
return {
    "nvim-telescope/telescope.nvim", -- fuzzy finder
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        'nvim-telescope/telescope-ui-select.nvim',
        { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },

    config = function()
        -- import telescope actions safely
        telescope = require("telescope")
        actions = require("telescope.actions")

        telescope.setup {
            -- configure custom mappings
            defaults = {
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next, -- move to next result
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
                    },
                },
            },
            -- You dont need to set any of these options. These are the default ones. Only
            -- the loading is important
            extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                },
            },
        }

        -- Enable Telescope extensions if they are installed
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        -- See `:help telescope.builtin`
        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = '[ ] Find Files' })
        vim.keymap.set('n', '<leader>ff', builtin.buffers, { desc = '[F]ind existing Bu[f]fers' })
        vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
        vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = '[F]ind [S]tring by grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind existing [B]uffers' })

        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
        vim.keymap.set('n', '<leader>ft', builtin.builtin, { desc = '[F]ind Select [T]elescope' })
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
        vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
        vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })

        vim.keymap.set('n', '<leader>fa', function ()
            builtin.find_files { hidden=true }
        end, { desc = '[F]ind [A]al Files (incl. hidden)' })

        -- telescope git commands
        vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "List All [G]it [C]ommits"})
        vim.keymap.set("n", "<leader>gf", builtin.git_bcommits, { desc = "List [G]it Commits for current [F]ile/Buffer"})
        vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "List [G]it [B]ranches"})
        vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "List [G]it [S]tatus (Current Changes Per File With Diff Preview)"})

        -- Slightly advanced example of overriding default behavior and theme
        vim.keymap.set('n', '<leader>/', function()
            -- You can pass additional configuration to Telescope to change the theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = '[/] Fuzzily find in current buffer' })

        -- It's also possible to pass additional configuration options.
        --  See `:help telescope.builtin.live_grep()` for information about particular keys
        vim.keymap.set('n', '<leader>f/', function()
            builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
            }
        end, { desc = '[F]ind [/] in Open Files' })

        -- Shortcut for searching your Neovim configuration files
        vim.keymap.set('n', '<leader>fn', function()
            builtin.find_files { cwd = vim.fn.stdpath 'config' }
        end, { desc = '[F]ind [N]eovim files' })
    end,
}

