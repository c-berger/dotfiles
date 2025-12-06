-- managing & installing LSP servers, linters & formatters
return {
    {
        "williamboman/mason.nvim", -- in charge of managing lsp servers, linters & formatters
        opts = {},
    },

    {
        "williamboman/mason-lspconfig.nvim", -- bridges gap b/w mason & lspconfig
        opts = {
            ensure_installed = {
                -- list of servers for mason to install
                -- see: https://github.com/williamboman/mason-lspconfig.nvim
                "bashls", -- Bash
                "clangd", -- C/C++
                -- "csharp_ls", "omnisharp", "omnisharp_mono", -- C#
                "cmake", -- CMake
                -- "dockerls", -- Docker
                "lua_ls", -- Lua
                "marksman", -- Markdown
                "pyright", -- Python
                -- ...
            },
            -- auto-install configured servers (with lspconfig)
            automatic_installation = true,
        },
    },

    {
        "neovim/nvim-lspconfig", -- easily configure language servers
        config = function()
            ---------------------------------------------------------------------
            -- Diagnostic symbols
            ---------------------------------------------------------------------
            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.INFO] = " ",
                        [vim.diagnostic.severity.HINT] = "󰠠 ",
                    },
                    linehl = {
                        [vim.diagnostic.severity.ERROR] = "Error",
                        [vim.diagnostic.severity.WARN] = "Warn",
                        [vim.diagnostic.severity.INFO] = "Info",
                        [vim.diagnostic.severity.HINT] = "Hint",
                    },
                },
            })

            ---------------------------------------------------------------------
            -- on_attach: keymaps when LSP attaches
            ---------------------------------------------------------------------
            local on_attach = function(client, bufnr)
                local function map(keys, cmd, desc)
                    vim.keymap.set("n", keys, cmd, {
                        desc = "LSP: " .. desc,
                        noremap = true,
                        silent = true,
                        buffer = bufnr,
                        nowait = true,
                    })
                end

                -- Lspsaga + Telescope bindings
                map("K", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation")
                map("gr", "<cmd>Lspsaga finder<CR>", "[G]oto [R]eferences")
                map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                map("gd", "<cmd>Lspsaga goto_definition<CR>", "[G]oto [D]efinition")
                map("gi", "<cmd>Lspsaga finder imp<CR>", "[G]oto [I]mplementations")

                map("<leader>co", "<cmd>Lspsaga outline<CR>", "[C]ode [O]outline")
                map("<leader>ca", "<cmd>Lspsaga code_action<CR>", "[C]ode [A]ction")
                map("<leader>cr", "<cmd>Lspsaga rename<CR>", "[C]ode [R]ename")

                map("<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", "[C]ode [D]iagnostics for Line")
                map("<leader>cD", "<cmd>Lspsaga show_cursor_diagnostics<CR>", "[C]ode [D]iagnostics for Cursor")
                map("<leader>cp", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "[C]ode Diagnostics [P]revious")
                map("<leader>cn", "<cmd>Lspsaga diagnostic_jump_next<CR>", "[C]ode Diagnostics [N]ext")
                map("<leader>p", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "[P]revious Diagnostics")
                map("<leader>n", "<cmd>Lspsaga diagnostic_jump_next<CR>", "[N]ext Diagnostics")

                map("<leader>cf", vim.lsp.buf.format, "[C]ode [F]ormat")

                map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
                map("<leader>cs", require("telescope.builtin").lsp_document_symbols, "[C]ode [S]ymbols in Document")
                map(
                    "<leader>cS",
                    require("telescope.builtin").lsp_dynamic_workspace_symbols,
                    "[C]ode [S]ymbols in Workspace"
                )
            end

            ---------------------------------------------------------------------
            -- LSP server configurations
            ---------------------------------------------------------------------
            local lspconfig = vim.lsp.config
            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local capabilities = cmp_nvim_lsp.default_capabilities()

            lspconfig.clangd = {
                cmd = { "clangd", "--offset-encoding=utf-16" },
                capabilities = capabilities,
                on_attach = on_attach,
            }

            lspconfig.lua_ls.setup = {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        -- make the language server recognize "vim" global
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            -- make language server aware of runtime files
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            },
                        },
                    },
                },
            }

            lspconfig.pyright.setup = {
                capabilities = capabilities,
                on_attach = on_attach,
            }

            lspconfig.cmake.setup = {
                capabilities = capabilities,
                on_attach = on_attach,
            }
        end,
    },

    -------------------------------------------------------------------------
    -- Null-ls (formatting + linting)
    -------------------------------------------------------------------------
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            local formatting = null_ls.builtins.formatting
            local diagnostics = null_ls.builtins.diagnostics
            null_ls.setup({
                sources = {
                    formatting.prettier,
                    formatting.stylua,
                    formatting.black,
                    formatting.clang_format,

                    -- diagnostics.cpplint,
                    -- diagnostics.flake8,
                    -- diagnostics.rubocop,
                    -- formatting.rubocop,
                },
            })

            vim.keymap.set("n", "<leader>lf", function()
                vim.lsp.buf.format({ async = true })
            end, { desc = "LSP: [F]ormat File" })
        end,
    },

    {
        "jayp0521/mason-null-ls.nvim", -- bridges gap b/w mason & null-ls
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        opts = {
            ensure_installed = nil,
            automatic_installation = true,
        },
    },

    -------------------------------------------------------------------------
    -- Lspsaga
    -------------------------------------------------------------------------
    {
        "nvimdev/lspsaga.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("lspsaga").setup({
                finder = {
                    keys = {
                        quit = { "<ESC>" },
                        toggle_or_open = { "<CR>", "<Space>" },
                    },
                },
                definition = {
                    keys = { quit = { "<ESC>" } },
                },
                outline = {
                    keys = {
                        quit = { "<ESC>" },
                        jump = { "<CR>" },
                        toggle_or_jump = { "<Space>" },
                    },
                },
                code_action = {
                    keys = {
                        quit = { "<ESC>" },
                        exec = { "<CR>" },
                    },
                },
                rename = {
                    keys = {
                        quit = { "<ESC>" },
                        exec = { "<CR>" },
                    },
                    in_select = false,
                },
            })
        end,
    },
}
