return {
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
        require('which-key').setup()

        -- Document existing key chains
        require('which-key').register {
            ['<leader>f'] = { name = '[F]ind', _ = 'which_key_ignore' },
            ['<leader>d'] = { name = '[D]iff', _ = 'which_key_ignore' },
            ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
            ['<leader>l'] = { name = '[L]SP', _ = 'which_key_ignore' },
            ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
            ['<leader>s'] = { name = '[S]plits/[S]ession', _ = 'which_key_ignore' },
        }
    end,
}
