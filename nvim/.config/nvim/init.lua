-- This is my init.lua file for Neovim. It's heavily inspired by the kickstart.nvim project.
-- https://github.com/nvim-lua/kickstart.nvim

-- THe documentation of the folder structure can be found in :h rtp

-- In the first run, you might need to run:
-- `nvim --headless "+Lazy! sync" +qa`

-- About the font: I do like DejaVu Sans Mono, so remember to install DejaVuSansM Nerd Font:
-- https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/DejaVuSansMono.zip
-- Make sure to not configure something that ends in Mono to prevent small icons.
-- It needs to be configured in the terminal emulator. Check the alacritty.yml file.

-- If you want to clean up everything, remember to run:
-- rm -rf ~/.local/share/nvim/ ~/.local/state/nvim/ ~/.cache/nvim/

---------------------
-- Global settings --
---------------------

-- Set the leader key before anything else, see :help mapleader
-- Set <space> as the leader key and local leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Open Ex by pressing leader & e
-- I am now using oil.nvim, check lua/plugins/oil.lua
-- vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Navigate through the quickfix faster.
vim.keymap.set("n", "<C-j>", vim.cmd.cafter)
vim.keymap.set("n", "<C-k>", vim.cmd.cbefore)

-- Set highlight on search results
vim.o.hlsearch = false

-- Set syntax off
-- vim.cmd.syntax 'off'

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
require('lazy').setup("plugins")

-- You reached the bottom of the file, the rest of the stuff should be under ./lua

-- See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

