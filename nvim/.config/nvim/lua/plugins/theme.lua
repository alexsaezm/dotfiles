return {
    -- I love tempus themes so much that
    -- I wanted to have a backup of them
    'alexsaezm/tempus-themes-vim',
    priority = 1000,
    config = function()
        vim.cmd.colorscheme 'tempus_classic'
    end,
}
