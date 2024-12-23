return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',

  -- Set a git tag to use the prebuild binaries
  version = 'v0.8.1',
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- See the full "keymap" documentation for information on defining your own keymap.
    -- https://cmp.saghen.dev/configuration/keymap.html#enter
    keymap = {
      preset = 'enter',
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    completion = {
      menu = {
        -- The default is to show
        auto_show = false,
      },
      -- Show documentation when selecting a completion item
      documentation = { auto_show = true, auto_show_delay_ms = 500 },

      -- Display a preview of the selected item on the current line
      -- Looks like it only works properly with auto_show set to true
      -- I have it disable right now because it's a little bit uncomfortable
      ghost_text = { enabled = false },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      -- Disable cmdline completions
      -- it's horrible if you are on the default preset or auto_show is set to true
      -- cmdline = {},
    },
    -- Experimental signature help support
    signature = { enabled = true }
  },
  opts_extend = { "sources.default" }
}
