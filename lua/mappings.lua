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
    [","] = { "@:", "Repeat last command" },
    ["r"] = { "<cmd>reg<cr>", "Show registers" },

    ["<leader>]"] = { "<cmd>bn<cr>", "[BUFFER] Go previous buffer" },
    ["<leader>["] = { "<cmd>bp<cr>", "[BUFFER] Go next buffer" },
    ["<leader>q"] = { "<cmd>bd<cr>", "[BUFFER] Close current buffer" },
    ["<leader>Q"] = { "<cmd>%bd|e#|bd#<cr>", "[BUFFER] Close other buffers" },

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
   
    ["ca"] = { ":lua vim.lsp.buf.code_action()<cr>", "[LSP] Code actions" },
    
    ["<leader>d"] = {
        name = "[DAP debug]",
        c = { ":lua require'dap'.continue()<CR>", "[DAP] Start/continue debug"},
        t = { ":lua require'dap'.toggle_breakpoint()<cr>", "[DAP] Toggle breakpoint" },
	    cb = { ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "[DAP] Set conditional breakpoint" },
	    lb = { ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", "[DAP] Set log point breakpoint" },
	    b = { ":lua require'dap'.set_breakpoint(nil, nil, nil)<cr>", "[DAP] Set breakpoint" },
	    r = { ":lua require'dap'.repl.open()<cr>", "[DAP] Repl open" },
	    l = { ":lua require'dap'.run_last()<cr>", "[DAP] Run last" },
    },
    ["<F10>"] = { ":lua require'dap'.step_over()<cr>", "[DAP] Step over" },
    ["<F11>"] = { ":lua require'dap'.step_into()<cr>", "[DAP] Step into" },
    ["<F12>"] = { ":lua require'dap'.step_out()<cr>", "[DAP] Step out" },

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
