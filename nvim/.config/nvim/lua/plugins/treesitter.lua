return {
	-- Highlight, edit, and navigate code
	'nvim-treesitter/nvim-treesitter',
	dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
	build = ':TSUpdate',
	config = function () 
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			-- I switch really often between different languages, so I want to make sure I have them all installed.
			ensure_installed = { all },

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = true,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed local
			auto_install = true,

			-- My theme doesn't support treesitter for now
			highlight = { enable = false },

			indent = { enable = true },

			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
		})
	end,

}
