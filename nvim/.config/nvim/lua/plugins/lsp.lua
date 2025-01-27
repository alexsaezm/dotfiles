return {
  -- Neovim has support for LSP by default but we need to configure each server.
  -- Remember that LSP does not autocomplete, it can populate the `autocompletion`, but showing suggestions is blink's tasks.
  -- In order to install new LSPs, remember to do a `:LspInstall` and then add the setup()
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup()
    require("lspconfig").gopls.setup({})
    require("lspconfig").harper_ls.setup({})
    require("lspconfig").lua_ls.setup({})
  end
}
