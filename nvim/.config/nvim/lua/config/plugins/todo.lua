return {
	'folke/todo-comments.nvim',
	event = 'VimEnter',
	dependencies = { 'nvim-lua/plenary.nvim' },
	opts = {
	},
	keys = {
		{'<leader>st', '<CMD>TodoTelescope<CR>', desc = 'Search TODO comments'}
	}
}
