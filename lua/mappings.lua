local ok, wk = pcall(require, "which-key")

if not ok then
    return
end

-- Space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Normal mode mappings
local n_opts = {
    mode = "n",
    prefix = "",
    silent = true,
    noremap = true,
    nowait = true,
}

wk.register({
    ["<c-a>"] = { "ggVG", "[SELECT] Select all" },

    -- Edit
    ["<leader>p"] = { '"_diwP', "Replace word with paste" },
    ["<a-j>"] = { ":m .+1<cr>==", "Move line down" },
    ["<a-k>"] = { ":m .-2<cr>==", "Move line up" },
    ["<a-Bs>"] = { "diw", "Delete word" },
    ["<a-c>"] = { "ciw", "Change word" },
    ["<a-f>"] = { "<cmd>TSTextobjectSelect @parameter.outer<cr>d", "Delete function parameter" },
    ["<a-x>"] = { "mzwdw`z", "Delete next word" },
    ["<a-\\>"] = { "ci(", "Change inside parentheses" },
    ["E"] = { "ge", "Jump backwards to end of word" },
    ["<leader>o"] = { "o<ESC>", "New line in normal mode" },
    ["<leader>O"] = { "O<ESC>", "New line before in normal mode" },
    ---- Following remaps conflict with Neoscroll plugin for scrolling animations
    ["<c-d>"] = { "<c-d>zz", "Keep cursor in the middle while scrolling down" },
    ["<c-u>"] = { "<c-u>zz", "Keep cursor in the middle while scrolling up" },
    ----
    ["n"] = { "nzz", "Keep searching result in the middle" },
    ["N"] = { "Nzz", "Keep searching result in the middle" },

    -- Motions
    ["H"] = { "^", "[MOTION] Move to first character of line" },
    ["L"] = { "$", "[MOTION] Move to last character of line" },
    ["<a-m>"] = { "]m", "[MOTION] Move to next method" },
    ["<a-M>"] = { "[m", "[MOTION] Move to previous method" },

    -- Windows and buffers
    ["<c-h>"] = { "<c-w>h", "[WINDOW] Focus in left window" },
    ["<c-j>"] = { "<c-w>j", "[WINDOW] Focus in bottom window" },
    ["<c-k>"] = { "<c-w>k", "[WINDOW] Focus in top window" },
    ["<c-l>"] = { "<c-w>l", "[WINDOW] Focus in right window" },
    ["<c-p>"] = { "<cmd>bn<cr>", "[BUFFER] Go previous buffer" },
    ["<c-n>"] = { "<cmd>bp<cr>", "[BUFFER] Go next buffer" },
    ["<a-t>"] = { "<cmd>ene<cr>", "[BUFFER] Open a new empty buffer" },
    ["WQ"] = { "<cmd>wqall<cr>", "[BUFFER] Quit and save all" },
    ["W"] = { "<cmd>wall<cr>", "[BUFFER] Save all" },
    ["Q"] = { "<cmd>qall!<cr>", "[BUFFER] Quit all without saving" },
    ["<a-q>"] = { "<cmd>bd!<cr>", "[BUFFER] Close current buffer" },
    ["<a-w>"] = { "<cmd>%bd!|e#|bd#<cr>", "[BUFFER] Close other buffers" },

    -- Folds
    ["--"] = { "zR", "[FOLDS] Expand all folds" },

    -- Macros and registers
    ["t"] = { '"_', "Set black hole registry" },
    ["qj"] = { '@q', "Execute macro saved in 'q' register" },
    [","] = { "@:", "Repeat last command" },

    -- Find
    [";;"] = { "<cmd>noh<cr>", "Clean search highlights" },
    ["<leader>f"] = {
        name = "[TELESCOPE]",
        f = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "[TELESCOPE] Find File" },
        n = { "<cmd>Telescope grep_string<cr>", "[TELESCOPE] Find files using grep in file names" },
        g = { "<cmd>Telescope live_grep<cr>", "[TELESCOPE] Find File by live grep (search content inside file)" },
        b = { "<cmd>Telescope buffers<cr>", "[TELESCOPE] Find buffers" },
        m = { "<cmd>Telescope marks<cr>", "[TELESCOPE] Marks" },
        h = { "<cmd>Telescope oldfiles<cr>", "[TELESCOPE] Recent files" },
        z = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "[TELESCOPE] Current buffer fuzzy find" },
        t = { "<cmd>TodoTelescope<cr>", "[TELESCOPE] TODO list" },
        c = { "<cmd>Telescope command_history<cr>", "[TELESCOPE] Search command history" },
        x = { "<cmd>Telescope neoclip<cr>", "[TELESCOPE] Search in clipboard manager" },
        p = { "<cmd>Telescope projects<cr>", "[TELESCOPE] Search projects" },
        db = { "<cmd>Telescope dap list_breakpoints<cr>", "[TELESCOPE DAP] Breakpoints" },
        dc = { "<cmd>Telescope dap configurations<cr>", "[TELESCOPE DAP] Debug configurations" },
        dv = { "<cmd>Telescope dap variables<cr>", "[TELESCOPE DAP] Variables" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "[TELESCOPE LSP] Find symbols" },
        r = { "<cmd>Telescope lsp_references<cr>", "[TELESCOPE LSP] Find references" },
    },

    -- Views
    ["<leader>v"] = {
        name = "[Views]",
        f = { "<cmd>NeoTreeShowToggle<cr>", "[NEOTREE] Toggle" },
        p = { "<cmd>TroubleToggle<cr>", "[TROUBLE] Toggle" },
        s = { "<cmd>AerialToggle<cr>", "[AERIAL] Toggle" },
        t = { "<cmd>ToggleTerm<cr>", "[TOGGLETERM] Open new terminal" },
        u = { "<cmd>UndotreeToggle<cr>", "[UNDOTREE]Toggle undotree" },
    },

    -- Debug
    ["<leader>d"] = {
        name = "[DAP debug]",
        r = { "<cmd>lua require'dap'.run_last()<cr>", "[DAP] Run last" },
        R = { "<cmd>lua require'dap'.run()<cr>", "[DAP] Run" },
        d = { "<cmd>DapContinue<cr>", "[DAP] Debug/Resume" },
        k = { "<cmd>DapTerminate<cr>", "[DAP] Terminate" },
        b = { "<cmd>DapToggleBreakpoint<cr>", "[DAP] Toggle breakpoint" },
        B = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
            "[DAP] Set conditional breakpoint" },
        l = { "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
            "[DAP] Set log point breakpoint" },
        v = { "<cmd>DapStepOver<cr>", "[DAP] Step over" },
        i = { "<cmd>DapStepInto<cr>", "[DAP] Step into" },
        o = { "<cmd>DapStepOut<cr>", "[DAP] Step out" },
        x = { "<cmd>lua require('dapui').eval()<cr>", "[DAPUI] Evaluate}" },
        p = { "<cmd>DapToggleRepl<cr>", "[DAP] Repl open" },
        u = { "<cmd>lua require'dapui'.toggle()<cr>", "[DAPUI] Toggle debugging UI" },
    },

    -- Code navigation
    ["<leader>c"] = {
        name = "[Code navigation]",
        c = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "[LSP] Go to declaration" },
        d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "[LSP] Go to definition" },
        t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "[LSP] Go to type definition" },
        i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "[LSP] Go to implementation" },
        s = { "<cmd>lua require'jdtls'.super_implementation()<cr>", "[JDLTS] Go to super implementation" },
        r = { "<cmd>lua vim.lsp.buf.references()<cr>", "[LSP] Go to references" },
        v = { "<cmd>Lspsaga hover_doc<cr>", "[LSP] Hover" },
        h = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "[LSP] Signature help" },
    },

    -- Refactoring
    ["<leader>r"] = {
        name = "[Code refactor]",
        r = { "<cmd>Lspsaga code_action<cr>", "[LSP] Code actions" },
        f = { "<cmd>lua vim.lsp.buf.format { async = true }<cr>", "[LSP] Format code" },
        n = { "<cmd>Lspsaga rename<cr>", "[LSP] Rename" },
        o = { "<cmd>lua require'jdtls'.organize_imports()<cr>", "[JDLTS] Organize imports" },
    },

    -- Errors and diagnostics
    ["<leader>e"] = {
        name = "[Diagnostics]",
        n = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "[DIAG] Go to next error" },
        p = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "[DIAG] Go to previous error" },
    },

    -- Git
    ["<leader>g"] = {
        name = "[GIT]",
        s = { "<cmd>Gitsigns toggle_signs<cr>", "[GIT] Toggle signs" },
        h = { "<cmd>Gitsigns preview_hunk<cr>", "[GIT] Preview hunk" },
        d = { "<cmd>Gitsigns diffthis<cr>", "[GIT] Diff" },
        n = { "<cmd>Gitsigns next_hunk<cr>", "[GIT] Next hunk" },
        p = { "<cmd>Gitsigns prev_hunk<cr>", "[GIT] Prev hunk" },
    },
}, n_opts)

-- Insert mode mappings
local i_opts = {
    mode = "i",
    prefix = "",
    silent = true,
    noremap = true,
    nowait = true,
}

wk.register({
    ["jk"] = { "<Esc>", "Normal mode switch" },
    ["JK"] = { "<Esc>", "Normal mode switch" },
    ["<a-d>"] = { "<Del>", "Handy DEL on insert mode" },
    ["<a-Bs>"] = { "<C-o>diw", "Delete word" },
    ["<a-c>"] = { "<C-o>ciw", "Change word" },
    ["<a-e>"] = { "<C-o>de", "Delete to end of word" },
    ["<a-w>"] = { "<C-o>w", "Move to next word" },
    ["<a-b>"] = { "<C-o>b", "Move to previous word" },
    ["<a-j>"] = { "<ESC>:m .+1<cr>==gi", "[MOVE] Move block down" },
    ["<a-k>"] = { "<ESC>:m .-2<cr>==gi", "[MOVE] Move block up" },
}, i_opts)

-- Visual mode mappings
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
    ["<leader>dx"] = { "<cmd>lua require('dapui').eval()<CR>", "[DAPUI] Evaluate (selection in visual mode) }" },
}, v_opts)

-- Select mode mappings
local s_opts = {
    mode = "s",
    prefix = "",
    silent = true,
    noremap = true,
    nowait = true,
}
wk.register({
    ["<a-Bs>"] = { "<C-o>diw", "Delete word" },
    ["<a-c>"] = { "<C-o>ciw", "Change word" },
}, s_opts)


wk.setup {}

