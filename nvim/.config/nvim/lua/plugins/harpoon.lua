return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    -- Disable ftplugin/mail.vim <leader>q shortcuts, they interfere with my shortcuts
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "gitsendemail",
      callback = function ()
        vim.api.nvim_buf_del_keymap(0, "n", "<leader>q")
      end
    })

    vim.keymap.set("n", "<leader>m", function()
      harpoon:list():add()
    end, { desc = 'Mark current file' })
    vim.keymap.set("n", "<leader>q", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Show marks menu' })

    vim.keymap.set("n", "<leader>1", function()
      harpoon:list():select(1)
    end, { desc = 'Go to mark 1' })
    vim.keymap.set("n", "<leader>2", function()
      harpoon:list():select(2)
    end, { desc = 'Go to mark 2' })
    vim.keymap.set("n", "<leader>3", function()
      harpoon:list():select(3)
    end, { desc = 'Go to mark 3' })
    vim.keymap.set("n", "<leader>4", function()
      harpoon:list():select(4)
    end, { desc = 'Go to mark 4' })
    vim.keymap.set("n", "<leader>5", function()
      harpoon:list():select(5)
    end, { desc = 'Go to mark 5' })
  end
}
