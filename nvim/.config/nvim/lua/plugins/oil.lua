return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    view_options = {
      show_hidden = true,
    },
  },
  keys = {
    { "<leader>e", "<CMD>Oil<CR>", desc = "Open current directory" }
  }
}
