-- I don't use this a lot, as I prefer to use Tmux. But sometimes you want a quick terminal at hand.
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      -- Open a floating terminal using space + t only on normal mode.
      open_mapping = [[<leader>t]],
      insert_mappings = false,
      direction = "float"
    })
  end
}
