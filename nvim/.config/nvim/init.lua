-- This is my init.lua file for Neovim. It's heavily based on the kickstart.nvim project.
-- https://github.com/nvim-lua/kickstart.nvim

-- In the first run, you need to run:
-- `nvim --headless "+Lazy! sync" +qa`

-- About the font: I do like DejaVu Sans Mono, so remember to install DejaVuSansM Nerd Font:
-- https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/DejaVuSansMono.zip
-- Make sure to not configure something that ends in Mono to prevent small icons.
-- It needs to be configured in the terminal emulator. Check the alacritty.yml file.

--------------
-- Settings --
--------------

-- Set the leader key before anything else, see :help mapleader
-- Set <space> as the leader key and local leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Open Ex by pressing leader & e
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, {desc = "Open file [e]xplorer"})
-- Set highlight on search results
vim.o.hlsearch = false
-- Set incremental search (search as you type)
vim.opt.incsearch = true
-- Set termguicolors to enable 24-bit RGB colors in the TUI
vim.o.termguicolors = true
-- Line numbers
vim.o.nu = true
-- Set relative line numbers
vim.o.relativenumber = true
-- Enable mouse mode
vim.o.mouse = 'a'
-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
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

-------------
-- Plugins --
-------------

-- If you remove this section, this file will still work.

-- Install package manager
-- https://github.com/folke/lazy.nvim
-- See `:help lazy.nvim.txt`
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Plugin configuration is noisy so I install
-- and configure them directly from `./lua/plugins/`
require('lazy').setup({
  -- First, the plugins that don't require configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'lewis6991/gitsigns.nvim',
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  -- Fast and feature-rich surround actions
  'echasnovski/mini.surround',

  -- Second, load the plugins plugins that require configuration.
  { import = 'plugins' },
})

-- See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
