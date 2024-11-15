return {
	'stevearc/oil.nvim',
	version = '*',
	dependencies = {
		'nvim-tree/nvim-web-devicons',
	},
	opts = {
		view_options = {
			show_hidden = true,
		}
	},
	keys = {
		{'<leader>e', '<CMD>Oil<CR>', desc = 'Open current directory'}
	}
}
