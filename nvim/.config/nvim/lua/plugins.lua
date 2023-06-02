-- Bootstrap packer
-- By default, packer is not installed but it's a little painful to do it manually in a new system
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Remember to install things by typing :PackerSync
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Tempus is a collection of themes for Vim and terminal emulators that are compliant at the very least with the WCAG AA accessibility standard for colour contrast
    use 'https://gitlab.com/protesilaos/tempus-themes-vim'

    -- Fancier statusline
    use 'nvim-lualine/lualine.nvim'

    -- Highlight, edit, and navigate code
    use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})
    use({'nvim-treesitter/playground', run = ':TSUpdate'})

    -- Additional text objects via treesitter
    use {'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter'}

    -- Undo history
    use 'mbbill/undotree'

    -- LSP Configuration & Plugins
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},

        }
    }
    -- Install dap support
    use {
        'mfussenegger/nvim-dap',
        requires = {
            {'theHamsta/nvim-dap-virtual-text'},
            {'rcarriga/nvim-dap-ui'},
            {'nvim-telescope/telescope-dap.nvim'},
        },
        ft = {'go', 'lua'},
        version = '*',
    }
    -- dnf install zeal
    use('KabbAmine/zeavim.vim')


    -- Avoid using Escape that much
    -- lua with packer.nvim
    use {
      "max397574/better-escape.nvim",
      config = function()
        require("better_escape").setup()
      end,
    }

    -- Go support
    use('fatih/vim-go')

    -- Fuzzy Finder (files, lsp, etc)
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

    -- Harpoon is a plugin for easily saving and jumping to bookmarks in your code.
    use { 'ThePrimeagen/harpoon', requires = { 'nvim-lua/plenary.nvim' } }

    -- Git related plugins
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'lewis6991/gitsigns.nvim'
    use {
        'ldelossa/gh.nvim',
        requires = { { 'ldelossa/litee.nvim' } }
    }
    use {
        'pwntester/octo.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'kyazdani42/nvim-web-devicons',
        },
        config = function ()
            require"octo".setup()
        end
    }

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = { 
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    }

    -- Lua
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }


    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
