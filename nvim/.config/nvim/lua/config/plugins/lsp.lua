return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        'j-hui/fidget.nvim',
        'saghen/blink.cmp',
    },

    opts = {
        servers = {
            lua_ls = {},
            gopls = {
                settings = {
                    gopls = {
                        gofumpt = true,
                        codelenses = {
                            gc_details = false,
                            generate = true,
                            regenerate_cgo = true,
                            run_govulncheck = true,
                            test = true,
                            tidy = true,
                            upgrade_dependency = true,
                            vendor = true,
                        },
                        hints = {
                            assignVariableTypes = true,
                            compositeLiteralFields = true,
                            compositeLiteralTypes = true,
                            constantValues = true,
                            functionTypeParameters = true,
                            parameterNames = true,
                            rangeVariableTypes = true,
                        },
                        analyses = {
                            nilness = true,
                            unusedparams = true,
                            unusedwrite = true,
                            useany = true,
                        },
                        usePlaceholders = true,
                        completeUnimported = true,
                        staticcheck = true,
                        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                        semanticTokens = true,
                    },
                },
            },
        }
    },
    -- Capabilities
    config = function(_, opts)
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {})
        require('fidget').setup({})
        require('mason').setup()
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }
        -- TODO Right now mason doesn't ensure something is installed
        -- require('mason-lspconfig').setup {
        --     handlers = {
        --         function(server_name)
        --             local server = servers[server_name] or {}
        --             server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        --             require('lspconfig')[server_name].setup(server)
        --         end,
        --     },
        -- }
        local lspconfig = require('lspconfig')
        for server, config in pairs(opts.servers) do
            -- passing config.capabilities to blink.cmp merges with the capabilities in your
            -- `opts[server].capabilities, if you've defined it
            config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
            lspconfig[server].setup(config)
        end

        -- See `:help LspAttach`
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end
                map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
                map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
                map('gr', require('telescope.builtin').lsp_references, 'Goto References')
                map('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
                map('<leader>ca', vim.lsp.buf.code_action, 'Selects a code action available at the current cursor position', { 'n', 'x' })
                map('<leader>cr', vim.lsp.buf.rename, 'Renames all references to the symbol under the cursor', { 'n', 'x' })
                map('<leader>ch', vim.lsp.buf.signature_help, 'Displays signature information about the symbol under the cursor in a floating window', { 'n', 'x' })
            end
        })
    end
}
-- vim: ts=4 sts=4 sw=4 et