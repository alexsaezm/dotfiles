return {
    'ThePrimeagen/harpoon',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        -- I don't want to group them together as I want to use them fast
        -- Also, grouping them together using which-key makes weird things happen like autoopen the files or failing to open the quick menu
        vim.keymap.set("n", "<leader>m", mark.add_file, {desc = "[M]ark file with Harpoon"})
        vim.keymap.set("n", "<leader>q", ui.toggle_quick_menu, {desc = "Show Harpoon [q]ick menu"})
        vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, {desc = "Navigate to 1st file in Harpoon"})
        vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, {desc = "Navigate to 2nd file in Harpoon"})
        vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, {desc = "Navigate to 3rd file in Harpoon"})
        vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, {desc = "Navigate to 4th file in Harpoon"})
        vim.keymap.set("n", "<leader>5", function() ui.nav_file(4) end, {desc = "Navigate to 5th file in Harpoon"})
    end
}
