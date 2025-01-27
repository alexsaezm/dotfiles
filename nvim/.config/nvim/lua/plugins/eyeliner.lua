return {
  "jinh0/eyeliner.nvim",
  config = function()
    require "eyeliner".setup {
      highlight_on_key = true,
      dim = false,
      vim.api.nvim_set_hl(0, "EyelinerPrimary", { bold = true, underline = true }),
      vim.api.nvim_set_hl(0, "EyelinerSecondary", { underline = true }),
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          vim.api.nvim_set_hl(0, "EyelinerPrimary", { bold = true, underline = true })
          vim.api.nvim_set_hl(0, "EyelinerSecondary", { underline = true })
        end,
      }),

      -- Set the maximum number of characters eyeliner.nvim will check from
      -- your current cursor position; this is useful if you are dealing with
      -- large files: see https://github.com/jinh0/eyeliner.nvim/issues/41
      max_length = 500,

      -- filetypes for which eyeliner should be disabled;
      -- e.g., to disable on help files:
      -- disabled_filetypes = {"help"}
      disabled_filetypes = {},

      -- buftypes for which eyeliner should be disabled
      -- e.g., disabled_buftypes = {"nofile"}
      disabled_buftypes = {},

      -- add eyeliner to f/F/t/T keymaps;
      -- see section on advanced configuration for more information
      default_keymaps = true,
    }
  end
}
