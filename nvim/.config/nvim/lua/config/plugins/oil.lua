return {
  'stevearc/oil.nvim',
  version = '*',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    view_options = {
      show_hidden = true,
    },
    float = {
      win_options = {
        winblend = 0
      }
    },
    keymaps = {
      ["<leader>d"] = {
        desc = "Toggle file detail view",
        callback = function()
          detail = not detail
          if detail then
            require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
          else
            require("oil").set_columns({ "icon" })
          end
        end,
      },
    },
  },
  keys = {
    { '<leader>e', '<CMD>Oil<CR>', desc = 'Open current directory' }
  }
}