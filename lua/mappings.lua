
local ok, wk = pcall(require, "which-key")

if not ok then
    return
end


local i_opts = {
    mode = "i",
    prefix = "",
    silent = true,
    noremap = true,
    nowait = true,
}


wk.register({
    ["jk"] = { "<Esc>", "Normal mode switch" },
    ["<A-d>"] = { "<Del>", "Easy backspace in insert mode (also workd by default with Ctrl+h)" },
}, i_opts)


local n_opts = {
    mode = "n",
    prefix = "",
    silent = true,
    noremap = true,
    nowait = true,
}

wk.register({
    -- [","] = { "@:", "Repeat last command" },
    ["<leader>r"] = { "<cmd>reg<cr>", "Show registers" },
    ["<leader>o"] = { "o<ESC>", "New line in normal mode" },
    ["<leader>O"] = { "O<ESC>", "New line before in normal mode" },
    ["<leader>p"] = { '"_diwP', "Replace word with paste" }, -- "_ is the black hole registry. Deleting in this registry wont overwrite default registry
    [";;"] = { "<cmd>:noh<cr>", "Clean search highlights" },

    ["<leader>]"] = { "<cmd>bn<cr>", "[BUFFER] Go previous buffer" },
    ["<leader>["] = { "<cmd>bp<cr>", "[BUFFER] Go next buffer" },
    ["q"] = { "<cmd>bd<cr>", "[BUFFER] Close current buffer" },
    ["Q"] = { "<cmd>%bd|e#|bd#<cr>", "[BUFFER] Close other buffers" },
   
    ["_"] = { "zR", "[BLOCK] Expand all blocks" },
    ["+"] = { "zo", "[BUFFER] Expand block" },
    ["-"] = { "zc", "[BUFFER] Close block" },
    ["=="] = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "[BUFFER] Format code" },

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
        c = { "<cmd>Telescope command_history<cr>", "[TELESCOPE] Search command history"},
        db = { "<cmd>Telescope dap list_breakpoints<cr>", "[TELESCOPE DAP] Breakpoints"},
        dc = { "<cmd>Telescope dap configurations<cr>", "[TELESCOPE DAP] Debug configurations"},
        dv = { "<cmd>Telescope dap variables<cr>", "[TELESCOPE DAP] Varibles"},
    },
    -- Vscode simular
    ["<c-p>"] = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "[TELESCOPE] Find File" },

    ["<F5>"] = { "<cmd>NeoTreeShowToggle<cr>", "[Neotree] Toggle" },
    ["<F6>"] = { "<cmd>TroubleToggle<cr>", "[Trouble] Toggle" },
    ["<F8>"] = { "<cmd>AerialToggle<cr>", "[Aerial] Toggle" },
   
    ["<leader>d"] = {
        name = "[DAP debug]",
        c = { "<cmd>DapContinue<cr>", "[DAP] Start/continue debug"},
        k = { "<cmd>DapTerminate<cr>", "[DAP] Terminate" },
        b = { "<cmd>DapToggleBreakpoint<cr>", "[DAP] Toggle breakpoint" },
	    cb = { ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "[DAP] Set conditional breakpoint" },
	    lb = { ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", "[DAP] Set log point breakpoint" },
	    r = { "<cmd>DapToggleRepl", "[DAP] Repl open" },
	    l = { ":lua require'dap'.run_last()<cr>", "[DAP] Run last" },
        o = { ":lua require'dapui'.setup()<cr> :lua require'dapui'.open()<cr>", "[DAPUI] Open debugging UI" },
        x = { ":lua require'dapui'.close()<cr>", "[DAPUI] Close debugging UI" },
    },
    ["<F10>"] = { ":lua require'dap'.step_over()<cr>", "[DAP] Step over" },
    ["<F11>"] = { ":lua require'dap'.step_into()<cr>", "[DAP] Step into" },
    ["<F12>"] = { ":lua require'dap'.step_out()<cr>", "[DAP] Step out" },

    ["<leader>c"] = {
        name = "[LSP]",
        r = { "<cmd>lua vim.lsp.buf.references()<cr>", "[LSP] Go to references"},
        d = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "[LSP] Go to declaration" },
        f = { "<cmd>lua vim.lsp.buf.definition()<cr>", "[LSP] Go to definition" },
        i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "[LSP] Go to implementation" },
        a = { ":lua vim.lsp.buf.code_action()<cr>", "[LSP] Code actions" },
        v = { ":lua vim.lsp.buf.hover()<cr>", "[LSP] Hover" },
        h = { ":lua vim.lsp.buf.signature_help()<cr>", "[LSP] Signature help" },
    },

  --[[   vim.api.nvim_set_keymap("n", "<leader>cx", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    vim.api.nvim_set_keymap("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
    vim.api.nvim_set_keymap(
        "n",
        "gl",
        '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>',
        opts)
    vim.api.nvim_set_keymap("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
    vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
     ]]
   

    ["<C-\\>"] = { ":ToggleTerm<cr>", "[ToggleTerm] Open new terminal" },
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
    prefix = "",
    silent = true,
    noremap = true,
    nowait = true,
}

wk.register({
}, v_opts)

wk.setup {}
