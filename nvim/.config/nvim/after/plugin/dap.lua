local M = {
    'mfussenegger/nvim-dap',
    dependencies = {
        'theHamsta/nvim-dap-virtual-text',
        'rcarriga/nvim-dap-ui',
        'jbyuki/one-small-step-for-vimkind',
        'nvim-telescope/telescope.nvim',
        'nvim-telescope/telescope-dap.nvim',
    },
    ft = {'go', 'lua'},
    version = '*',
}

M.config = function()
    local keymap = vim.keymap.set

    require('nvim-dap-virtual-text').setup()

    keymap(
        { 'n', 'v' },
        '<F4>',
        "<cmd>lua require('dapui').toggle()<CR>",
        { silent = true, desc = 'DAP toggle UI' }
    )
    keymap(
        { 'n', 'v' },
        '<F5>',
        "<cmd>lua require('dap').continue()<CR>",
        { silent = true, desc = 'DAP launch or continue' }
    )
    keymap(
        { 'n', 'v' },
        '<F6>',
        "<cmd>lua require('dap').step_over()<CR>",
        { silent = true, desc = 'DAP step over' }
    )
    keymap(
        { 'n', 'v' },
        '<F7>',
        "<cmd>lua require('dap').step_into()<CR>",
        { silent = true, desc = 'DAP step into' }
    )
    keymap(
        { 'n', 'v' },
        '<F8>',
        "<cmd>lua require('dap').step_out()<CR>",
        { silent = true, desc = 'DAP step out' }
    )
    keymap(
        { 'n', 'v' },
        '<leader>db',
        "<cmd>lua require('dap').toggle_breakpoint()<CR>",
        { silent = true, desc = 'DAP toggle breakpoint' }
    )
    keymap(
        { 'n', 'v' },
        '<leader>dB',
        "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
        { silent = true, desc = 'set breakpoint with condition' }
    )
    keymap(
        { 'n', 'v' },
        '<leader>dp',
        "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
        { silent = true, desc = 'set breakpoint with log point message' }
    )
    keymap(
        { 'n', 'v' },
        '<leader>dr',
        "<cmd>lua require('dap').repl.toggle()<CR>",
        { silent = true, desc = 'toggle debugger REPL' }
    )

    local telescope_dap = require('telescope').extensions.dap

    keymap({ 'n', 'v' }, '<leader>d?', function()
        telescope_dap.commands({})
    end, { silent = true, desc = 'DAP builtin commands' })
    keymap({ 'n', 'v' }, '<leader>dl', function()
        telescope_dap.list_breakpoints({})
    end, { silent = true, desc = 'DAP breakpoint list' })
    keymap({ 'n', 'v' }, '<leader>df', function()
        telescope_dap.frames()
    end, { silent = true, desc = 'DAP frames' })
    keymap({ 'n', 'v' }, '<leader>dv', function()
        telescope_dap.variables()
    end, { silent = true, desc = 'DAP variables' })
    keymap({ 'n', 'v' }, '<leader>dx', function()
        telescope_dap.configurations()
    end, { silent = true, desc = 'DAP debugger configurations' })

    -- configure dap-ui and language adapaters
    require('plugins.dap.ui')
    if vim.fn.executable('dlv') == 1 then
        require('plugins.dap.go')
    end
    require('plugins.dap.lua')

    require('telescope').load_extension('dap')
end

return M
