return {
    {
        -- autocompletion
        "hrsh7th/nvim-cmp", -- completion plugin
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- source for text in buffer
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer", -- source for text in buffer
            "hrsh7th/cmp-path", -- source for file system paths
            "hrsh7th/cmp-cmdline", -- source for file system paths
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")

            -- load vs-code like snippets from plugins (e.g. friendly-snippets)
            require("luasnip/loaders/from_vscode").lazy_load()

            vim.opt.completeopt = "menu,menuone,noselect"

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                    ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                    ["<C-e>"] = cmp.mapping.abort(), -- close completion window
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item() -- next suggestion
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump() -- next snipped expansion location
                        else
                            fallback()
                        end
                    end),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item() -- previous suggestion
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1) -- previous expasion location
                        else
                            fallback()
                        end
                    end),
                }),
                sources = cmp.config.sources({
                    { name = "codeium" }, -- AI completion
                    { name = "nvim_lsp" }, -- lsp
                    { name = "nvim_lua" }, -- lsp
                    { name = "luasnip" }, -- snippets
                    { name = "buffer" }, -- text within current buffer
                    { name = "path" }, -- file system paths
                }),
                -- configure lspkind for vs-code like icons
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol",
                        maxwidth = 50,
                        ellipsis_char = "...",
                        symbol_map = { Codeium = "" },
                    }),
                },
            })

            -- `/` cmdline setup based on current buffer.
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            -- `:` cmdline setup
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
                matching = { disallow_symbol_nonprefix_matching = false },
            })
        end,
    },
    {
        "L3MON4D3/LuaSnip", -- snippet engine
        build = (function()
            -- Build Step is needed for regex support in snippets.
            -- This step is not supported in many windows environments.
            -- Remove the below condition to re-enable on windows.
            -- if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            --     return
            -- end
            return "make install_jsregexp"
        end)(),
        dependencies = {
            "saadparwaiz1/cmp_luasnip", -- for autocompletion
            "onsails/lspkind.nvim", -- vs-code like icons for autocompletion
            {
                "rafamadriz/friendly-snippets",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
        },
    },
}
