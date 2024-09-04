local ok, wk = pcall(require, "which-key")

if not ok then
	return
end

-- Space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- NORMAL MODE MAPPINGS
wk.add({
    -- Edition
	{ "<c-s>", "ggVG", desc = "[SELECT] Select all" },
	-- {"d", '"_d',desc= "Do not copy when deleting" },
	-- {"D", '"_D',desc= "Do not copy when deleting" },
	-- {"dd", '"_dd',desc= "Do not copy when deleting" },
	{ "c", '"_c', desc = "Do not copy when changing" },
	{ "C", '"_C', desc = "Do not copy when changing" },
	{ "cc", '"_cc', desc = "Do not copy when changing" },

	{ "<a-p>", '"_diwP', desc = "Replace word with paste" },
	{ "<a-s-p>", '"_ddP', desc = "Replace line with paste" },

	{ "<a-j>", ":m .+1<cr>==", desc = "Move line down" },
	{ "<a-k>", ":m .-2<cr>==", desc = "Move line up" },

	{ "<a-d>", '"_diw', desc = "Delete word" },
	{ "<a-c>", '"_ciw', desc = "Change word" },
	{ "<a-s-d>", '<cmd>lua require("various-textobjs").subword(true)<cr>"_d', desc = "Delete subword" },
	{ "<a-s-c>", '<cmd>lua require("various-textobjs").subword(true)<cr>"_c', desc = "Change subword" },
	{ "<a-z>", '"_c<plug>(matchup-i%)', desc = "Change within block delimiters or quotes" },
	{ "<a-x>", '"_ci(', desc = "Change within parentheses" },

	{ "<a-a>", '<cmd>TSTextobjectSelect @parameter.inner<cr>"_c', desc = "Change function parameter" },
	{ "<a-s>", '<cmd>TSTextobjectSelect @parameter.outer<cr>"_d', desc = "Delete function parameter" },

	{ "<a-o>", "mao<ESC>`a", desc = "New line in normal mode" },
	{ "<a-O>", "maO<ESC>`a", desc = "New line before in normal mode" },

    -- Motions
	{ "H", "^", desc = "[MOTION] Move to first character of line" },
	{ "L", "$", desc = "[MOTION] Move to last character of line" },
	{ "W", "<cmd>lua require('spider').motion('w')<cr>", desc = "[MOTION] Spider-w motion" },
	{ "B", "<cmd>lua require('spider').motion('b')<cr>", desc = "[MOTION] Spider-b motion" },
	{ "E", "<cmd>lua require('spider').motion('e')<cr>", desc = "[MOTION] Spider-e motion" },
	{ "gE", "<cmd>lua require('spider').motion('ge')<cr>", desc = "[MOTION] Spider-ge motion" },
	---- Following remaps conflict with Neoscroll plugin for scrolling animations
	{ "<c-d>", "<c-d>zz", desc = "Keep cursor in the middle while scrolling down" },
	{ "<c-u>", "<c-u>zz", desc = "Keep cursor in the middle while scrolling up" },
	----
	{ "n", "nzz", desc = "Keep searching result in the middle" },
	{ "N", "Nzz", desc = "Keep searching result in the middle" },

	{ "<a-down>", "<cmd>TSTextobjectGotoNextStart @function.outer<cr>", desc = "[MOTION] Move to next method" },
	{ "<a-up>", "<cmd>TSTextobjectGotoPreviousStart @function.outer<cr>", desc = "[MOTION] Move to previous method" },

    -- Buffers
	---- Without bufferline
	-- { "<a-right>", "<cmd>bn<cr>", desc = "[BUFFER] Go previous buffer" },
	-- { "<a-left>", "<cmd>bp<cr>", desc = "[BUFFER] Go next buffer" },
	---- With bufferline
	{ "<a-left>", "<cmd>BufferLineCyclePrev<cr>", desc = "[BUFFER] Go previous buffer" },
	{ "<a-right>", "<cmd>BufferLineCycleNext<cr>", desc = "[BUFFER] Go next buffer" },
	{ "<a-b>", "<cmd>e #<cr>", desc = "[BUFFER] Switch to other buffer" },
	{ "<a-t>", "<cmd>ene<cr>", desc = "[BUFFER] Open a new empty buffer" },
	{ "Z", "<cmd>wall<cr>", desc = "[BUFFER] Save all" },
	{ "Q", "<cmd>qall!<cr>", desc = "[BUFFER] Quit all without saving" },
	---- Using famiu/bufdelete.nvim plugin commands to prevent messy behaviours with other plugins
	{ "<a-q>", "<cmd>Bdelete!<cr>", desc = "[BUFFER] Close current buffer" },
	{ "<a-w>", "<cmd>%bd!|e#|bd#<cr>", desc = "[BUFFER] Close other buffers" },

    -- Folds
	{ "|", "za", desc = "[FOLDS] Toggle fold" },
	{ "--", "zA", desc = "[FOLDS] Toggle all folds" },
	{ "<a-s-down>", "zr", desc = "[FOLDS] Increase fold level" },
	{ "<a-s-up>", "zm", desc = "[FOLDS] Decrease fold level" },
	-- { "<a-down>", "zo", desc = "[FOLDS] Open fold" },
	-- { "<a-up>", "zc", desc = "[FOLDS] Close fold" },

    -- Macros and registers
	{ "t", '"_', desc = "Set black hole registry" },
	{ "qj", "@q", desc = "Execute macro saved in 'q' register" },

    -- Find
	{ ";;", "<cmd>noh<cr>", desc = "Clean search highlights" },
	{ "<leader>f", group = "Find" },
	{ "<leader>fe", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", desc = "[TELESCOPE] Find File" },
	{ "<leader>fn", "<cmd>Telescope grep_string<cr>", desc = "[TELESCOPE] Find files using grep in file names" },
	{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "[TELESCOPE] Find File by live grep (search content)" },
	{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "[TELESCOPE] Find buffers" },
	{ "<leader>fm", "<cmd>Telescope marks<cr>", desc = "[TELESCOPE] Marks" },
	{ "<leader>fh", "<cmd>Telescope oldfiles<cr>", desc = "[TELESCOPE] Recent files" },
	{ "<leader>fd", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "[TELESCOPE] Current buffer fuzzy find" },
	{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "[TELESCOPE] TODO list" },
	{ "<leader>fc", "<cmd>Telescope command_history<cr>", desc = "[TELESCOPE] Search command history" },
	{ "<leader>fx", "<cmd>Telescope neoclip<cr>", desc = "[TELESCOPE] Search in clipboard manager" },
	{ "<leader>fp", "<cmd>Telescope projects<cr>", desc = "[TELESCOPE] Search projects" },
	{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "[TELESCOPE LSP] Find symbols" },
	{ "<leader>fz", "<cmd>Telescope zoxide list<cr>", desc = "[TELESCOPE] Zoxide" },
	{ "<leader>ff", "<cmd>Telescope frecency<cr>", desc = "[TELESCOPE] Frecency" },
	{ "<leader>fic", "<cmd>Telescope git_commits<cr>", desc = "[TELESCOPE] Git commits" },
	{ "<leader>fib", "<cmd>Telescope git_branches<cr>", desc = "[TELESCOPE] Git branches" },
	{ "<leader>fis", "<cmd>Telescope git_status<cr>", desc = "[TELESCOPE] Git status" },
	{ "<leader>fih", "<cmd>Telescope git_stash<cr>", desc = "[TELESCOPE] Git stash" },

    -- Views
	{ "<leader>v", group = "Views" },
	{ "<leader>vf", "<cmd>NeoTreeFocusToggle<cr>", desc = "[NEOTREE] Toggle file tree view" },
	{ "<leader>vp", "<cmd>TroubleToggle<cr>", desc = "[TROUBLE] Toggle problem and diagnostics view" },
	{ "<leader>vs", "<cmd>AerialToggle<cr>", desc = "[AERIAL] Toggle file structure view" },
	{ "<leader>vt", "<cmd>ToggleTerm<cr>", desc = "[TOGGLETERM] Open new terminal" },
	{ "<leader>vu", "<cmd>UndotreeToggle<cr>", desc = "[UNDOTREE]Toggle last undoable changes view" },

    -- Debug
	{ "<leader>d", group = "Debug" },
	{ "<leader>dR", "<cmd>lua require'dap'.run()<cr>", desc = "[DAP] Run" },
	{ "<leader>de", "<cmd>lua require'dap'.run_last()<cr>", desc = "[DAP] Debug last" },
	{ "<leader>dE", "<cmd>Telescope dap configurations<cr>", desc = "[DAP] Show debug configurations" },
	{ "<leader>dk", "<cmd>DapTerminate<cr>", desc = "[DAP] Terminate" },
	{ "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "[DAP] Toggle breakpoint" },
	{ "<leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", desc = "[DAP] Set conditional breakpoint", },
	{ "<leader>dl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", desc = "[DAP] Set log point breakpoint", },
	{ "<leader>dc", "<cmd>DapContinue<cr>", desc = "[DAP] Continue" },
	{ "<leader>dv", "<cmd>DapStepOver<cr>", desc = "[DAP] Step oVer" },
	{ "<leader>di", "<cmd>DapStepInto<cr>", desc = "[DAP] Step Into" },
	{ "<leader>do", "<cmd>DapStepOut<cr>", desc = "[DAP] Step Out" },
	{ "<leader>dx", "<cmd>lua require('dapui').eval()<cr>", desc = "[DAPUI] eXecute}" },
	{ "<leader>dp", "<cmd>DapToggleRepl<cr>", desc = "[DAP] Repl open" },
	{ "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", desc = "[DAPUI] Toggle debugging UI" },
	{ "<leader>ds", "<cmd>Telescope dap list_breakpoints<cr>", desc = "[TELESCOPE DAP] Show all breakpoints" },
	{ "<leader>dw", "<cmd>Telescope dap variables<cr>", desc = "[TELESCOPE DAP] Wariables" },
    
    -- Code navigation
	{ "<leader>c", group = "Code navigation" },
	{ "<leader>cl", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "[LSP] Go to declaration" },
	{ "<leader>cd", "<cmd>Glance definitions<cr>", desc = "[LSP] Go to definition" },
	-- {"<leader>cd", "<cmd>lua vim.lsp.buf.definition()<cr>", desc= "[LSP] Go to definition" },
	{ "<leader>ct", "<cmd>Glance type_definitions<cr>", desc = "[LSP] Go to type definition" },
	-- {"<leader>ct", "<cmd>lua vim.lsp.buf.type_definition()<cr>", desc= "[LSP] Go to type definition" },
	{ "<leader>ci", "<cmd>Telescope lsp_implementations<cr>", desc = "[LSP] Go to implementation" },
	-- {"<leader>ci", "<cmd>lua vim.lsp.buf.implementation()<cr>", desc= "[LSP] Go to implementation" },
	{ "<leader>cs", "<cmd>lua require'jdtls'.super_implementation()<cr>", desc = "[JDLTS] Go to super implementation" },
	{ "<leader>cr", "<cmd>Telescope lsp_references<cr>", desc = "[LSP] Go to references" },
	-- {"<leader>cr", "<cmd>lua vim.lsp.buf.references()<cr>", desc= "[LSP] Go to references" },
	{ "<leader>cv", "<cmd>Lspsaga hover_doc<cr>", desc = "[LSP] Hover" },
	{ "<leader>cc", "<cmd>Telescope lsp_incoming_calls<cr>", desc = "[LSP] Show incoming Calls" },
	{ "<leader>ch", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "[LSP] Signature Help" },
	{ "<leader>cx", "<cmd>lua require'telescope.builtin'.treesitter{ symbols = {'method', 'function', 'function_definition'}}<cr>", desc = "[TELESCOPE] Get current buffer functions", },

    -- Refactoring
	{ "<leader>r", group = "[Code Refactor]" },
	{ "<leader>re", "<cmd>Lspsaga code_action<cr>", desc = "[LSP] Code actions" },
	{ "<leader>rf", "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<cr>", desc = "[CONFORM] Format code", },
	{ "<leader>rn", "<cmd>Lspsaga rename<cr>", desc = "[LSP] Rename" },
	{ "<leader>ri", "<cmd>:Refactor inline_var <cr>", desc = "[REFACTOR] Inline variable" },
	{ "<leader>rI", "<cmd>:Refactor inline_func <cr>", desc = "[REFACTOR] Inline function" },

    -- Errors and diagnostics
	{ "<leader>e", group = "[Errors and diagnostics]" },
	{ "<leader>en", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "[DIAG] Go to next error" },
	{ "<leader>ep", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "[DIAG] Go to previous error" },

    -- Git
	{ "<leader>g", group = "[GIT]" },
	{ "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "[GIT] Diff" },
	{ "<leader>gn", "<cmd>Gitsigns next_hunk<cr>", desc = "[GIT] Next hunk" },
	{ "<leader>gp", "<cmd>Gitsigns prev_hunk<cr>", desc = "[GIT] Prev hunk" },
	{ "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>", desc = "[GIT] Preview hunk" },

    -- Display modes
	{ "<leader>m", group = "[Display Modes]" },
	{ "<leader>mz", "<cmd>ZenMode<cr>", desc = "[MODE] Toggle zen mode" },

    -- Jumps/Marks
	{ "<leader>j", group = "[Jumps]" },
	{ "<leader>jk", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "[HARPOON] Show quick menu" },
	{ "<leader>ja", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "[HARPOON] Add file" },
})

-- INSERT MODE MAPPINGS
wk.add({
	mode = { "i" },
	{ "jk", "<Esc>", desc = "Normal mode switch" },
	{ "<a-b>", "<C-o>b", desc = "Move to previous word" },
	{ "<a-c>", '<C-o>"_ciw', desc = "Change word" },
	{ "<a-d>", '<C-o>"_diw', desc = "Delete word" },
	{ "<a-e>", "<ESC>ea", desc = "Move to end of word" },
	{ "<a-j>", "<ESC>:m .+1<cr>==gi", desc = "[MOVE] Move block down" },
	{ "<a-k>", "<ESC>:m .-2<cr>==gi", desc = "[MOVE] Move block up" },
	{ "<a-s>", "<Del>", desc = "Handy DEL on insert mode" },
	{ "<a-w>", "<C-o>w", desc = "Move to next word" },
})

-- VISUAL MODE MAPPINGS
wk.add({
	mode = { "v" },
	{ "jk", "<Esc>", desc = "Normal mode switch" },
	{ "<c-s>", "ggOG", desc = "[SELECT] Select all" },
	{ "v", "^o$", desc = "[SELECT] Select trimmed line" },

    -- Edit
	{ "C", '"_C', desc = "Do not copy when changing" },
	{ "c", '"_c', desc = "Do not copy when changing" },
	{ "cc", '"_cc', desc = "Do not copy when changing" },
	{ "p", '"_dP', desc = "Paste without replacing what is was in clipboard" },
	{ "<a-j>", ":m '>+1<cr>gv=gv", desc = "[MOVE] Move block down" },
	{ "<a-k>", ":m '<-2<cr>gv=gv", desc = "[MOVE] Move block up" },

    -- Motions
	{ "<a-down>", "<cmd>TSTextobjectGotoNextStart @function.outer<cr>", desc = "[MOTION] Move to next method" },
	{ "<a-up>", "<cmd>TSTextobjectGotoPreviousStart @function.outer<cr>", desc = "[MOTION] Move to previous method" },
	{ "H", "^", desc = "[MOTION] Move to first character of line" },
	{ "L", "$", desc = "[MOTION] Move to last character of line" },
    { "gE", "<cmd>lua require('spider').motion('ge')<cr>", desc = "[MOTION] Spider-ge motion" },
	{ "B", "<cmd>lua require('spider').motion('b')<cr>", desc = "[MOTION] Spider-b motion" },
	{ "E", "<cmd>lua require('spider').motion('e')<cr>", desc = "[MOTION] Spider-e motion" },
	{ "W", "<cmd>lua require('spider').motion('w')<cr>", desc = "[MOTION] Spider-w motion" },
    { "<", "<gv", desc = "[Indent] Indent left" },
    { ">", ">gv", desc = "[Indent] Indent right" },
    { "<leader>dx", "<cmd>lua require('dapui').eval()<CR>", desc = "[DAPUI] Evaluate (selection in visual mode) }" },
})

-- Select mode mappings
wk.add({
	mode = { "s" },
    { "<a-Bs>", "<C-o>diw", desc = "Delete word" },
    { "<a-c>", "<C-o>ciw", desc = "Change word" },
})

-- Execution mode mappings
wk.add({
    mode = { "x" },
    { "<leader>r", group = "[Code refactor]" },
    { "<leader>rl", "<cmdr:Refactor extract_to_file <cr>", desc = "[REFACTOR] Extract to file" },
    { "<leader>rv", "<cmd>:Refactor extract_var <cr>", desc = "[REFACTOR] Extract variable" },
    { "<leader>rx", "<cmd>:Refactor extract <cr>", desc = "[REFACTOR] Extract function" },
})

-- Terminal mode mappings
wk.add({
    mode = { "t" },
    { "<c-h>", "<cmd>wincmd h<cr>,", desc = "[TERMINAL] Move left" },
    { "<c-j>", "<cmd>wincmd j<cr>,", desc = "[TERMINAL] Move down" },
    { "<c-k>", "<cmd>wincmd k<cr>,", desc = "[TERMINAL] Move up" },
    { "<c-l>", "<cmd>wincmd l<cr>,", desc = "[TERMINAL] Move right" },
})

wk.setup({})
