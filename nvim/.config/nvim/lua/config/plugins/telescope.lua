return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-ui-select.nvim',
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			'nvim-telescope/telescope-fzf-native.nvim',

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = 'make',

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
		},
		{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
	},
	config = function()
		local telescope = require("telescope")
		local telescopeConfig = require("telescope.config")

		-- Clone the default Telescope configuration
		local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

		-- I want to search in hidden/dot files.
		table.insert(vimgrep_arguments, "--hidden")
		-- I don't want to search in the `.git` directory.
		table.insert(vimgrep_arguments, "--glob")
		table.insert(vimgrep_arguments, "!**/.git/*")

		telescope.setup({
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
		})


		-- Enable Telescope extensions if they are installed
		pcall(require('telescope').load_extension, 'fzf')
		pcall(require('telescope').load_extension, 'ui-select')
		local builtin = require 'telescope.builtin'
		vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Search Buffers' })
		vim.keymap.set('n', '<leader>se', builtin.diagnostics, { desc = 'Search Errors' })
		vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search Files' })
		vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by Grep' })
		vim.keymap.set('n', '<leader>sm', builtin.man_pages, { desc = 'Search Man pages' })
		vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Search by Word' })
		vim.keymap.set('n', '<leader>ss', builtin.lsp_dynamic_workspace_symbols, { desc = 'Search by Symbols in the workspace' })
		vim.keymap.set('n', '<leader>sn', function()
			builtin.find_files { cwd = vim.fn.stdpath 'config' }
		end, { desc = 'Search Neovim files' })

		-- Git stuff
		vim.keymap.set('n', '<leader>sgb', builtin.git_branches, { desc = 'Search Git Branches' })
		vim.keymap.set('n', '<leader>sgc', builtin.git_commits, { desc = 'Search Git Commits' })
		vim.keymap.set('n', '<leader>sgf', builtin.git_files, { desc = 'Search Git Files' })
	end
}
