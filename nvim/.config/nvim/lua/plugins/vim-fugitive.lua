return {
    'tpope/vim-fugitive',
    dependencies = {
        'tpope/vim-rhubarb', -- GitHub support
        'shumphrey/fugitive-gitlab.vim', -- GitLab support
        'FrostyX/vim-fugitive-pagure', -- Pagure support
    },
    config = function()
        vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
        vim.keymap.set('n', '<leader>go', vim.cmd.GBrowse)
        vim.keymap.set('n', '<leader>ga', vim.cmd.Gwrite)
        vim.keymap.set('n', '<leader>gl', function()
            vim.cmd.Git('log')
        end, {})
        vim.keymap.set('n', '<leader>gc', function()
            vim.cmd.Git('commit')
        end, {})
        vim.keymap.set('n', '<leader>gb', function()
            vim.cmd.Git('blame')
        end, {})
        vim.keymap.set('n', '<leader>gd', function()
            vim.cmd.Git('diff')
        end, {})
        vim.keymap.set('n', '<leader>gmt', function()
            vim.cmd.Git('mergetool')
        end, {})
    end,
}
