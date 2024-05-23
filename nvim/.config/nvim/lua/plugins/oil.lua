return {
	"stevearc/oil.nvim",
	config = function()
		require("oil").setup({
			view_options = {
				show_hidden = true,
			}
		})
		vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}

