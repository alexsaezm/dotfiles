return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- Fuzzy Finder Algorithm which requires local dependencies to be built.
        -- Only load if `make` is available. Make sure you have the system
        -- requirements installed.
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            -- NOTE: If you are having trouble with this installation,
            --       refer to the README for telescope-fzf-native for more instructions.
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
    },
    setup = {
        defaults = {
            mappings = {
                i = {
                    ['<C-u>'] = false,
                    ['<C-d>'] = false,
                },
            },
        },
    },
    config = function()
      require('which-key').register({
        f = {
            name = "Find",
            f = {require('telescope.builtin').find_files, "[F]ind in [F]iles"},
            t = {require('telescope.builtin').live_grep, "[F]ind [T]ext"},
            b = {require('telescope.builtin').buffers, "[F]ind in [B]uffers"},
            m = {require('telescope.builtin').man_pages, "[F]ind in [M]an pages"},
            e = {require('telescope.builtin').diagnostics, "[F]ind [E]rrors"},
            t = {require('telescope.builtin').speel_suggest, "[F]ind [T]ypos"},
            s = {require('telescope.builtin').lsp_document_symbols, "[F]ind document [S]ymbols"},
            ws = {require('telescope.builtin').lsp_dynamic_workspace_symbols, "[F]ind [W]orkspace [S]ymbols"},
            g = {require('telescope.builtin').git_files, "[F]ind in [G]it"},
            gc = {require('telescope.builtin').git_commits, "[F]ind [G]it [C]ommits"},
            gb = {require('telescope.builtin').git_branches, "[F]ind [G]it [B]ranches"},
        },
      }, {prefix = "<leader>"})
    end,
}
