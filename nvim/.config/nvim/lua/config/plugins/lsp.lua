return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'j-hui/fidget.nvim',
    'saghen/blink.cmp',
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim"
      },
      opts = { lsp = { auto_attach = true } }
    }
  },

  opts = {
    servers = {
      lua_ls = {},
      bashls = {},
      harper_ls = {},
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
    require('fidget').setup({})
    require('mason').setup()
    require('mason-lspconfig').setup {
      -- The list of LSP servers -> https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
      ensure_installed = {
        "lua_ls",
        "gopls",
        "bashls",
        "harper_ls",
        -- Can't use cmake right now because I have Python 3.13
        -- "cmake",
        --
      }
    }
    local lspconfig = require('lspconfig')
    for server, config in pairs(opts.servers) do
      -- passing config.capabilities to blink.cmp merges with the capabilities in your
      -- `opts[server].capabilities, if you've defined it
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
    vim.diagnostic.open_float()
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      signs = true,
      underline = true,
      update_on_insert = false,
    })
    local signs = {
      Error = "󰅚 ",
      Warn = "󰳦 ",
      Hint = "󱡄 ",
      Info = " ",
    }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = nil })
    end

    -- See `:help LspAttach`
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then return end
        if client.supports_method('textDocument/formatting') then
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = event.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
            end
          })
        end
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end
        map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
        map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
        map('gr', require('telescope.builtin').lsp_references, 'Goto References')
        map('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
        map('<leader>ca', vim.lsp.buf.code_action,
          'Selects a code action available at the current cursor position', { 'n', 'x' })
        map('<leader>cr', vim.lsp.buf.rename, 'Renames all references to the symbol under the cursor',
          { 'n', 'x' })
        map('<leader>ch', vim.lsp.buf.signature_help,
          'Displays signature information about the symbol under the cursor in a floating window', { 'n', 'x' })
      end
    })
  end
}
