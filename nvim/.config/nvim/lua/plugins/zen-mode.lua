return {
	"folke/zen-mode.nvim",
	opts = {
		window = {
			width = .50 -- width will be 85% of the editor width
		}
	},
	config = function()
		local zm = require("zen-mode")

		vim.keymap.set("n", "<leader>z", function() zm.toggle() end)

		-- Weird stuff happen when BufEnter is set. Better to leave it commented for now
		-- 	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		-- 		pattern = { "*.py", "*.lua", "*.go", "*.md" },
		-- 		callback = zm.open,
		-- 	})
		-- 	vim.api.nvim_create_autocmd({ "BufLeave" }, {
		-- 		pattern = { "*.py", "*.lua", "*.go", "*.md" },
		-- 		callback = zm.close,
		-- 	})
	end
}
