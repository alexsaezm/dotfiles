return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      -- This is used to run commands when the plugin is installed or updated.
      build = "make",
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font }
  },
  config = function()
    local telescopeConfig = require("telescope.config")

    -- Clone the default Telescope configuration
    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

    -- I want to search in hidden/dot files.
    table.insert(vimgrep_arguments, "--hidden")
    -- I don't want to search in the `.git` directory.
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")
    require("telescope").setup({
      defaults = {
        -- `hidden = true` is not supported in text grep commands.
        vimgrep_arguments = vimgrep_arguments,
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      }
    })
    -- Enable Telescope extensions
    pcall(require("telescope").load_extension("fzf"))
    pcall(require("telescope").load_extension("ui-select"))

    -- See `:help telescope.builtin`
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search Files" })
    vim.keymap.set("n", "<leader>st", builtin.live_grep, { desc = "Search Text" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search Word" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search Diagnostics" })
    vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Search Buffers" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search Keymaps" })

    -- Git keymaps.
    vim.keymap.set("n", "<leader>sc", builtin.git_commits, { desc = "Search Commits" })
    vim.keymap.set("n", "<leader>sb", builtin.git_branches, { desc = "Search Branches" })

    -- LSP keymaps. Remember:
    -- Ctrl + T uses the tagstack. See :help tagstack
    -- Ctrl + O uses the jumplist. See :help jumplist
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })
    vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Go to definition" })
    vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Go to references" })
    vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Go to implementation" })
    vim.keymap.set("n", "gt", builtin.lsp_type_definitions, { desc = "Go to type defintion" })
    vim.keymap.set("n", "gO", builtin.lsp_outgoing_calls, { desc = "Go to outgoing calls" })
    vim.keymap.set("n", "gI", builtin.lsp_incoming_calls, { desc = "Go to incoming calls" })
    vim.keymap.set("n", "<leader>ss", builtin.lsp_dynamic_workspace_symbols, { desc = "Search Symbols in the workspace" })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Show available Code Actions" })
    vim.keymap.set("n", "<leader>rs", vim.lsp.buf.rename,
      { desc = "Rename all references to the symbol under the cursor." })
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format current buffer" })
  end
}
