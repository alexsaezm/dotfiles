return {

	-- I love tempus themes so much that I wanted to have a backup of them
	'alexsaezm/tempus-themes-vim',
	priority = 1000,
	config = function()
		vim.cmd.colorscheme 'tempus_classic'
	end,

	-- Currently tempus doesn't support tree-sitter so it breaks.
	-- I am trying to adapt it but my lua-fu is 0.
	-- dir = "~/Code/src/github.com/alexsaezm/tempus.nvim",

}
