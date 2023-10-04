return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    {
      'williamboman/mason.nvim', config = true
    },
    'williamboman/mason-lspconfig.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    {
      'j-hui/fidget.nvim',
      tag = 'legacy',
      opts = {}
    },
    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
  },
  config = function()

    -- Format current buffer on save
    vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

    require('which-key').register({
      g = {
          name = "[G]o to",
          d = {vim.lsp.buf.definition, "[G]o to [D]efinition"},
          D = {vim.lsp.buf.declaration, "[G]o to [D]eclaration"},
          r = {vim.lsp.buf.references, "[G]o to [R]eferences"},
          i = {vim.lsp.buf.implementation, "[G]o to [I]mplementation"},
          e = {vim.diagnostic.goto_next, "[G]o to the next [E]rror"},
          E = {vim.diagnostic.goto_prev, "[G]o to the previous [E]rror"},
      },
    }, {prefix = "<leader>"})

    require('which-key').register({
      c = {
          name = "[C]ode",
          a = {vim.lsp.buf.code_action, "[C]ode [A]ction"},
          r = {vim.lsp.buf.rename, "[C]ode [R]ename"},
          q = {vim.diagnostic.setloclist, "[C]ode [Q]uickfix"},
      },
    }, {prefix = "<leader>"})

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. They will be passed to
    --  the `settings` field of the server config. You must look up that documentation yourself.
    --
    --  If you want to override the default filetypes that your language server will attach to you can
    --  define the property 'filetypes' to the map in question.
    local servers = {
      clangd = {},
      gopls = {},
      pyright = {},
      rust_analyzer = {},
      tsserver = {},
      html = { filetypes = { 'html', 'twig', 'hbs'} },

      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    }

    -- Enable gitsings. This maybe is not the best place for this.
    -- require('gitsigns').setup()

    -- Setup neovim lua configuration
    require('neodev').setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        }
      end
    }

    -- [[ Configure nvim-cmp ]]
    -- See `:help cmp`
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      },
    }
  end
}
