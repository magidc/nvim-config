local ok, wk = pcall(require, "which-key")

if not ok then
    return
end

-- Space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local i_opts = {
    mode = "i",
    prefix = "",
    silent = true,
    noremap = true,
    nowait = true,
}

wk.register({
    ["jk"] = { "<Esc>", "Normal mode switch" },
    ["<a-d>"] = { "<Del>", "Handy DEL on insert mode" },
    ["<a-j>"] = { "<ESC>:m .+1<cr>==gi", "[MOVE] Move block down" },
    ["<a-k>"] = { "<ESC>:m .-2<cr>==gi", "[MOVE] Move block up" },
}, i_opts)

local n_opts = {
    mode = "n",
    prefix = "",
    silent = true,
    noremap = true,
    nowait = true,
}

wk.register({
    [","] = { "@:", "Repeat last command" },
    ["<leader>r"] = { "<cmd>reg<cr>", "Show registers" },
    ["<leader>o"] = { "o<ESC>", "New line in normal mode" },
    ["<leader>O"] = { "O<ESC>", "New line before in normal mode" },
    ["<a-j>"] = { ":m .+1<cr>==", "[MOVE] Move line down" },
    ["<a-k>"] = { ":m .-2<cr>==", "[MOVE] Move line up" },

    ["t"] = { '"_', "Set black hole registry" },
    ["<leader>p"] = { '"_diwP', "Replace word with paste" }, -- "_ is the black hole registry. Deleting in this registry wont overwrite default registry
    [";;"] = { "<cmd>noh<cr>", "Clean search highlights" },

    ["<c-Up>"] = { "<cmd>resize +2<cr>", "[WINDOW] Make window taller" },
    ["<c-Down>"] = { "<cmd>resize -2<cr>", "[WINDOW] Make window shorter" },
    ["<c-Left>"] = { "<cmd>vertical resize -2<cr>", "[WINDOW] Make window narrower" },
    ["<c-Right>"] = { "<cmd>vertical resize +2<cr>", "[WINDOW] Make window wider" },

    -- Better window navigation
    ["<c-h>"] = { "<c-w>h", "[WINDOW] Focus in left window" },
    ["<c-j>"] = { "<c-w>j", "[WINDOW] Focus in bottom window" },
    ["<c-k>"] = { "<c-w>k", "[WINDOW] Focus in top window" },
    ["<c-l>"] = { "<c-w>l", "[WINDOW] Focus in right window" },

    ["<s-l>"] = { "<cmd>bn<cr>", "[BUFFER] Go previous buffer" },
    ["<s-h>"] = { "<cmd>bp<cr>", "[BUFFER] Go next buffer" },
    ["q"] = { "<cmd>bd<cr>", "[BUFFER] Close current buffer" },
    ["Q"] = { "<cmd>%bd|e#|bd#<cr>", "[BUFFER] Close other buffers" },
    ["--"] = { "zR", "[FOLDS] Expand all folds" },
    ["_"] = { "zM", "[FOLDS] Close all folds" },
    ["<leader>f"] = {
        name = "[TELESCOPE]",
        f = { "<cmd>Telescope find_files hidden=false no_ignore=true<cr>", "[TELESCOPE] Find File" },
        s = { "<cmd>Telescope grep_string<cr>", "[TELESCOPE] Find files using grep in file names" },
        g = { "<cmd>Telescope live_grep<cr>", "[TELESCOPE] Find File by live grep (search content inside file)" },
        b = { "<cmd>Telescope buffers<cr>", "[TELESCOPE] Find buffers" },
        h = { "<cmd>Telescope help_tags<cr>", "[TELESCOPE] Help tags" },
        m = { "<cmd>Telescope marks<cr>", "[TELESCOPE] Marks" },
        r = { "<cmd>Telescope oldfiles<cr>", "[TELESCOPE] Recent files" },
        z = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "[TELESCOPE] Current buffer fuzzy find" },
        --t = { "<cmd>Telescope tags<cr>", "[TELESCOPE] Tags" },
        --o = { "<cmd>Telescope current_buffer_tags<cr>", "[TELESCOPE] Current buffer tags"},
        c = { "<cmd>Telescope command_history<cr>", "[TELESCOPE] Search command history" },
        p = { "<cmd>Telescope projects<cr>", "[TELESCOPE] Search projects" },
        db = { "<cmd>Telescope dap list_breakpoints<cr>", "[TELESCOPE DAP] Breakpoints" },
        dc = { "<cmd>Telescope dap configurations<cr>", "[TELESCOPE DAP] Debug configurations" },
        dv = { "<cmd>Telescope dap variables<cr>", "[TELESCOPE DAP] Varibles" },
    },
    -- Vscode similar
    ["<c-p>"] = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "[TELESCOPE] Find File" },

    ["<c-1>"] = { "<cmd>NeoTreeShowToggle<cr>", "[Neotree] Toggle" },
    ["<c-2>"] = { "<cmd>TroubleToggle<cr>", "[Trouble] Toggle" },
    ["<c-3>"] = { "<cmd>AerialToggle<cr>", "[Aerial] Toggle" },

    ["<leader>d"] = {
        name = "[DAP debug]",
        d = { "<cmd>DapContinue<cr>", "[DAP] Start/continue debug" },
        k = { "<cmd>DapTerminate<cr>", "[DAP] Terminate" },
        b = { "<cmd>DapToggleBreakpoint<cr>", "[DAP] Toggle breakpoint" },
        cb = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
            "[DAP] Set conditional breakpoint" },
        lb = { "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
            "[DAP] Set log point breakpoint" },
        r = { "<cmd>DapToggleRepl", "[DAP] Repl open" },
        l = { "<cmd>lua require'dap'.run_last()<cr>", "[DAP] Run last" },
        o = { "<cmd>lua require'dapui'.open()<cr>", "[DAPUI] Open debugging UI" },
        c = { "<cmd>lua require'dapui'.close()<cr>", "[DAPUI] Close debugging UI" },
    },
    ["<F10>"] = { "<cmd>lua require'dap'.step_over()<cr>", "[DAP] Step over" },
    ["<F11>"] = { "<cmd>lua require'dap'.step_into()<cr>", "[DAP] Step into" },
    ["<F12>"] = { "<cmd>lua require'dap'.step_out()<cr>", "[DAP] Step out" },

    ["<leader>c"] = {
        name = "[LSP]",
        r = { "<cmd>lua vim.lsp.buf.references()<cr>", "[LSP] Go to references" },
        d = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "[LSP] Go to declaration" },
        f = { "<cmd>lua vim.lsp.buf.definition()<cr>", "[LSP] Go to definition" },
        i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "[LSP] Go to implementation" },
        a = { "<cmd>Lspsaga code_action<cr>", "[LSP] Code actions" },
        v = { "<cmd>Lspsaga hover_doc<cr>", "[LSP] Hover" },
        h = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "[LSP] Signature help" },
        c = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "[LSP] Format code" },
        n = { "<cmd>Lspsaga rename<cr>", "[LSP] Rename" },
    },
    ["<leader>j"] = {
        name = "[JDTLS]",
        o = { "<cmd>lua require'jdtls'.organize_imports()<cr>", "[JDLTS] Organize imports" },
    },

    ["<C-\\>"] = { "<cmd>ToggleTerm<cr>", "[ToggleTerm] Open new terminal" },

    ["<leader>g"] = {
        name = "[GIT]",
        s = { "<cmd>Gitsigns toggle_signs<cr>", "[GIT] Toggle signs" },
        h = { "<cmd>Gitsigns preview_hunk<cr>", "[GIT] Preview hunk" },
        d = { "<cmd>Gitsigns diffthis<cr>", "[GIT] Diff" },
        n = { "<cmd>Gitsigns next_hunk<cr>", "[GIT] Next hunk" },
        p = { "<cmd>Gitsigns prev_hunk<cr>", "[GIT] Prev hunk" },
    },
}, n_opts)

local v_opts = {
    mode = "v",
    nowait = true,
    prefix = "",
    silent = true,
    noremap = true,
}
wk.register({
    ["jk"] = { "<Esc>", "Normal mode switch" },
    ["p"] = { '"_dP', "Paste without replacing what is was in clipboard" },
    ["<"] = { "<gv", "[Indent] Indent left" },
    [">"] = { ">gv", "[Indent] Indent right" },
    ["<a-j>"] = { ":m '>+1<cr>gv=gv", "[MOVE] Move block down" },
    ["<a-k>"] = { ":m '<-2<cr>gv=gv", "[MOVE] Move block up" },
}, v_opts)

wk.setup {}
