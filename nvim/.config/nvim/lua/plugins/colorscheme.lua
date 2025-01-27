-- Remember to run :checkhealth while inside a tmux session to verify
-- everything is working
return {
  "sainnhe/sonokai",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.sonokai_enable_italic = true
    -- vim.g.sonokai_transparent_background = true
    vim.g.sonokai_style = "default"
    vim.cmd.colorscheme "sonokai"
  end
}
