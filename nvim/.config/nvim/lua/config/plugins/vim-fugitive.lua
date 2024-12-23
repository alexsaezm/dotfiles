return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git,
      { desc = 'Show git status' })

    vim.keymap.set('n', '<leader>gl', function()
      vim.cmd.Git('log')
    end, { desc = 'Show git log' })

    vim.keymap.set('n', '<leader>gc', function()
      vim.cmd.Git('commit')
    end, { desc = 'Open commit dialog' })

    vim.keymap.set('n', '<leader>gb', function()
      vim.cmd.Git('blame')
    end, { desc = 'Show git blame' })

    vim.keymap.set('n', '<leader>gmt', function()
      vim.cmd.Git('mergetool')
    end, { desc = 'Start git mergetool' })
  end
}
