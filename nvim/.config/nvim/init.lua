-- The lua guide is here https://neovim.io/doc/user/lua-guide.html

-- Set the leader key to the <space> key before anything else.
-- See :help mapleader and :help maplocalleader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enable relative line numbers. See :help relativenumbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode. See :help mouse
vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim. See help: clipboard
vim.opt.clipboard = 'unnamedplus'

-- Enable break ident
vim.opt.breakindent = true

-- Disable swapfile & backup
vim.opt.swapfile = false
vim.opt.backup = false

-- Enable persistent undo
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Set the minimum size for the gutter. See :help numberwidth
vim.opt.numberwidth = 5

-- Bootstrap lazy.nvim. See :help lazy.nvim.txt
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- Load the `./lua/plugins/` subdirectory. See :help runtimepath
-- I used to load the plugins based on alphabetical order but that can be
-- problematic:
-- require('lazy').setup('plugins')
require('lazy').setup({
  require 'config.plugins.colorscheme',
  require 'config.plugins.noice',
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
  require 'config.plugins.lualine',
  require 'config.plugins.autopairs',
})
