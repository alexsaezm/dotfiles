-- color scheme!
vim.o.termguicolors = true
vim.cmd('colorscheme tempus_classic')

-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- Spell checker
--vim.opt.spelllang = 'en_us'
--vim.opt.spell = true

-- Set the leader key to SPACE
vim.g.mapleader = " "

-- Open Ex by pressing leader & e
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Set lualine as statusline
-- See `:help lualine.txt`
-- Check the themes here https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'dracula',
        component_separators = '|',
        section_separators = '',
    },
}

--[[
vim.api.nvim_create_autocmd("BufRead", {
    pattern = {"*.log"},
    callback = function()
        vim.schedule(function()
        end)
    end,
})
--]]

vim.cmd([[
augroup ErrorsHighlighning
    autocmd!
    autocmd BufRead,BufNewFile *.log syn keyword Error error
    autocmd BufRead,BufNewFile *.log syn keyword Error errors
    autocmd BufRead,BufNewFile *.log syn keyword Error Error
    autocmd BufRead,BufNewFile *.log syn keyword Error ERR
    autocmd BufRead,BufNewFile *.log syn keyword Error ERROR
    autocmd BufRead,BufNewFile *.log syn keyword Error FAIL
    autocmd BufRead,BufNewFile *.log syn keyword Error fail
    autocmd BufRead,BufNewFile *.log syn keyword Error FAILED
    autocmd BufRead,BufNewFile *.log syn keyword Error failed
    autocmd BufRead,BufNewFile *.log syn keyword Error EXCEPTION
    autocmd BufRead,BufNewFile *.log syn keyword Error exception
augroup end
]])

