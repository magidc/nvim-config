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
        t = { "<cmd>Telescope tags<cr>", "[TELESCOPE] Tags" },
        o = { "<cmd>Telescope current_buffer_tags<cr>", "[TELESCOPE] Current buffer tags"},
        c = { "<cmd>Telescope command_history<cr>", "[TELESCOPE] Search command history"},
    },
    -- Vscode simular
    ["<c-p>"] = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "Command Prompt" },

    ["<F8>"] = { "<cmd>TagbarToggle<cr>", "[Tagbar] Toggle" },
    ["<F9>"] = { "<cmd>NeoTreeShowToggle<cr>", "[Neotree] Toggle" },
    ["<F10>"] = { "<cmd>TroubleToggle<cr>", "[Trouble] Toggle" },
   
    
    ["<leader>g"] = {
        name = "[GIT]",
        s = { "<cmd>Gitsigns toggle_signs<cr>", "[GIT] Toggle signs" },
        h = { "<cmd>Gitsigns preview_hunk<cr>", "[GIT] Preview hunk" },
        d = { "<cmd>Gitsigns diffthis<cr>", "[GIT] Diff" },
        n = { "<cmd>Gitsigns next_hunk<cr>", "[GIT] Next hunk" },
        p = { "<cmd>Gitsigns prev_hunk<cr>", "[GIT] Prev hunk" },
    },
}, n_opts)

wk.setup {}