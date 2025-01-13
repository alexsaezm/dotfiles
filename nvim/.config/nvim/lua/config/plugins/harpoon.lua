return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  config = function()
    local harpoon = require('harpoon')
    harpoon:setup()

    -- Configures Telescope for the harpoon:list menu
    -- I'm not currently using this due to some issues with how the menu handles the deletion of entries
    -- local conf = require("telescope.config").values
    -- local function toggle_telescope(harpoon_files)
    --   local file_paths = {}
    --   for _, item in ipairs(harpoon_files.items) do
    --     table.insert(file_paths, item.value)
    --   end
    --
    --   require("telescope.pickers").new({}, {
    --     prompt_title = "Harpoon",
    --     finder = require("telescope.finders").new_table({
    --       results = file_paths,
    --     }),
    --     previewer = conf.file_previewer({}),
    --     sorter = conf.generic_sorter({}),
    --   }):find()
    -- end

    vim.keymap.set("n", "<leader>m", function()
      harpoon:list():add()
    end, { desc = 'Mark current file' })
    vim.keymap.set("n", "<leader>q", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Show marks menu' })
    -- vim.keymap.set("n", "<leader>q", function()
    --   toggle_telescope(harpoon:list())
    -- end, { desc = 'Show marks menu' })

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
