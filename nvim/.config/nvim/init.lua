-- Set the leader to the <space> key before anything else. See :help mapleader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enable relative line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode. See :help mouse
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim. See :help clipboard
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.opt.swapfile = false

-- Disable backup
vim.opt.backup = false

-- Enable persistent undo
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Enable undo file
vim.opt.undofile = true

-- I don't need this block because I'm using harper but it might be useful to keep it around
-- Run spell check for specific file types
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "gitcommit", "markdown", "text" },
--   callback = function()
--     vim.opt_local.spell = true
--     vim.opt_local.spelllang = "en_us"
--   end,
--   group = vim.api.nvim_create_augroup("CommitSpellCheck", { clear = true }),
-- })

-- Install and enable lazy.nvim plugin manager. See :help lazy.nvim.txt
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)


-- Load the `./lua/plugins/` subdirectory. See :help runtimepath
-- I used to load the plugins based on alphabetical order but that can be
-- problematic:
-- require('lazy').setup('plugins')
require('lazy').setup({
  require 'config.plugins.colorscheme',
  require 'config.plugins.which-key',
  require 'config.plugins.telescope',
  require 'config.plugins.harpoon',
  require 'config.plugins.oil',
  require 'config.plugins.vim-fugitive',
  require 'config.plugins.undotree',
  require 'config.plugins.treesitter',
  require 'config.plugins.completion',
  require 'config.plugins.lsp',
  require 'config.plugins.dap',
  require 'config.plugins.vim-go',
  require 'config.plugins.lazydev',
  require 'config.plugins.todo',
})
