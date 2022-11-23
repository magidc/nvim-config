local ok, hydra = pcall(require, "hydra")

if not ok then
    return
end

hydra({
    name = 'Window reize/focus',
    mode = 'n',
    body = '<leader>w',
    heads = {
        { '<left>', '<c-w>>' },
        { '<right>', '<c-w><' },
        { '<up>', '<c-w>+' },
        { '<down>', '<c-w>-' },
        { 'h', '<c-w>h' },
        { 'j', '<c-w>j' },
        { 'k', '<c-w>k' },
        { 'l', '<c-w>l' },
    }
})

hydra({
    name = 'Fold navigation and management',
    mode = 'n',
    body = '<leader>z',
    heads = {
        { 'e', 'zr' },
        { 'E', 'zR' },
        { 'c', 'zm' },
        { 'C', 'zM' },
        { ' ', 'za' },
        { 'j', 'zj' },
        { 'k', 'zk' },
    }
})

local okdap, dap = pcall(require, "dap")

if not okdap then
    return
end

local hint_dap = [[
 _n_: Step over   _s_: Start/Continue   _C_: Close UI                   _v_: Hoover
 _s_: Step into   _x_: Quit             _b_: Breakpoint                 _r_: Toggle REPL
 _o_: Step out    _X_: Stop             _c_: Conditional breakpoint
 _l_: Run last    _O_: Open UI          _m_: Log point message
 
 ^ ^              _q_: exit
]]

hydra({
    hint = hint_dap,
    config = {
        color = 'pink',
        invoke_on_body = true,
        hint = {
            position = 'bottom',
            border = 'rounded'
        },
    },
    name = 'DAP',
    mode = { 'n' },
    body = '<leader>x',
    heads = {
        { 'n', dap.step_over, { silent = true } },
        { 's', dap.step_into, { silent = true } },
        { 'o', dap.step_out, { silent = true } },
        { 'r', ":lua require('dap.repl').toggle()<cr>", { silent = true } },
        { 'd', dap.continue, { silent = true } },
        { 'l', dap.run_last, { silent = true } },
        { 'b', dap.toggle_breakpoint, { silent = true } },
        { 'c', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", { silent = true } },
        { 'm', ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", { silent = true } },
        { 'q', nil, { exit = true, nowait = true } },
        -- { 'x', dap.disconnect({ terminateDebuggee = false }), { exit = true, silent = true } },
        { 'X', dap.close, { silent = true } },
        { 'O', ":lua require('dapui').open()<cr>:DapVirtualTextForceRefresh<cr>", { silent = true } },
        { 'C', ":lua require('dapui').close()<cr>", { silent = true } },
        { 'v', ":lua require('dap.ui.widgets').hover()<cr>", { silent = true } },
    }
})
