-- Neovim's Lua guide https://neovim.io/doc/user/lua-guide.html

-- Set the leader key to the <space> key before anything else.
-- See :help mapleader and :help maplocalleader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable relative line numbers. See `:help relativenumbers`
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode. See :help mouse
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim. See `:help clipboard`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Disable swapfile & backup
vim.o.swapfile = false
vim.o.backup = false
vim.o.updatetime = 50

-- Enable persistent undo
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

-- Draw the signcolumn always, to avoid flickering. See :help signcolumn
vim.o.signcolumn = "yes"

-- Minimal number of lines above and below. See :help scrolloff
vim.o.scrolloff = 10

-- Allow "@" and "-" in filenames. See :help 'isfname'
vim.opt.isfname:append("@-@")

-- Highlight when yanking text
-- See :help vim.highlight.on_yank()
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.diagnostic.config({
  virtual_text = false, -- Turn off inline diagnostics
})

-- Configure the integrated terminal
-- The default way to esc from the terminal is with C-\ C-N and I can't remember it
vim.api.nvim_set_keymap('t', '<ESC>', '<C-\\><C-n>', { noremap = true })
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    -- Disable numbering in the terminal
    vim.opt.number = false
    vim.opt.relativenumber = false
  end
})

-- Open a splitted terminal buffer
local job_id = 0
vim.keymap.set("n", "<space>t", function()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 5)
  -- Store the id of the terminal for later usage
  job_id = vim.bo.channel
end)

-- Center screen after a page jump
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump up and center" })

-- Force a reload of the buffer
vim.keymap.set("n", "<leader>rb", "<CMD>bufdo e!<CR>", { desc = "Reload the buffer. Warning: It discards everything" })

vim.o.laststatus = 2
vim.o.statusline = "%f %y %m %= %l:%c"

-- Bootstrap lazy.nvim. See `:help lazy.nvim.txt`
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

-- Load the plugins subdirectory. See `:help runtimepath` or `:help rtp`
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({ import = "plugins" }, {
  change_detection = {
    notify = false,
  },
})
