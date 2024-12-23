return {
  'alexsaezm/tempus-themes-vim',
  config = function()
    vim.cmd.colorscheme 'tempus_classic'
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end
}
