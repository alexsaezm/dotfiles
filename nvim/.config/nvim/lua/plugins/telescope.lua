return {
	-- For live and grep search:
	-- dnf install ripgrep
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		-- -- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- -- Only load if `make` is available. Make sure you have the system
		-- -- requirements installed.
		-- {
		-- 	'nvim-telescope/telescope-fzf-native.nvim',
		-- 	-- NOTE: If you are having trouble with this installation,
		-- 	--       refer to the README for telescope-fzf-native for more instructions.
		-- 	build = 'make',
		-- 	cond = function()
		-- 		return vim.fn.executable 'make' == 1
		-- 	end,
		-- },
	},
	config = function()
		local telescope = require('telescope')
		telescope.setup {
			pickers = {
				find_files = {
					-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
				-- By default, live grep doesn't search hidden files
				live_grep = {
					additional_args = function(opts)
						return {"--hidden"}
					end
				},
			}
		}
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set('n', '<leader>ft', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
		vim.keymap.set('n', '<leader>fm', builtin.man_pages, {})
		vim.keymap.set('n', '<leader>fe', builtin.diagnostics, {})
		vim.keymap.set('n', '<leader>fz', builtin.spell_suggest, {})
		-- LSP
		vim.keymap.set('n', '<leader>fds', builtin.lsp_document_symbols, {})
		vim.keymap.set('n', '<leader>ftd', builtin.lsp_type_definitions, {})
		vim.keymap.set('n', '<leader>fws', builtin.lsp_dynamic_workspace_symbols, {})
		vim.keymap.set('n', 'gd', builtin.lsp_definitions, {})
		vim.keymap.set('n', 'gr', builtin.lsp_references, {})
		vim.keymap.set('n', 'gi', builtin.lsp_implementations, {})
		-- Git
		vim.keymap.set('n', '<leader>fgf', builtin.git_files, {})
		vim.keymap.set('n', '<leader>fgc', builtin.git_commits, {})
		vim.keymap.set('n', '<leader>fgb', builtin.git_branches, {})

		-- Enable telescope fzf native, if installed
		-- pcall(require('telescope').load_extension, 'fzf')
	end,
}
