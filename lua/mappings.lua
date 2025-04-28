local ok, wk = pcall(require, "which-key")

if not ok then
	return
end

-- Space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- NORMAL MODE MAPPINGS
local n_opts = {
	mode = "n",
	prefix = "",
	silent = true,
	noremap = true,
	nowait = true,
}

wk.add({
	["<c-s>"] = { "ggVG", "[SELECT] Select all" },
	-- Edit
	-- ["d"] = { '"_d', "Do not copy when deleting" },
	-- ["D"] = { '"_D', "Do not copy when deleting" },
	-- ["dd"] = { '"_dd', "Do not copy when deleting" },
	["c"] = { '"_c', "Do not copy when changing" },
	["C"] = { '"_C', "Do not copy when changing" },
	["cc"] = { '"_cc', "Do not copy when changing" },

	["<a-p>"] = { '"_diwP', "Replace word with paste" },
	["<a-s-p>"] = { '"_ddP', "Replace line with paste" },

	["<a-j>"] = { ":m .+1<cr>==", "Move line down" },
	["<a-k>"] = { ":m .-2<cr>==", "Move line up" },

	["<a-d>"] = { '"_diw', "Delete word" },
	["<a-c>"] = { '"_ciw', "Change word" },
	["<a-s-d>"] = { '<cmd>lua require("various-textobjs").subword(true)<cr>"_d', "Delete subword" },
	["<a-s-c>"] = { '<cmd>lua require("various-textobjs").subword(true)<cr>"_c', "Change subword" },
	["<a-z>"] = { '"_c<plug>(matchup-i%)', "Change within block delimiters or quotes" },
	["<a-x>"] = { '"_ci(', "Change within parentheses" },

	["<a-a>"] = { '<cmd>TSTextobjectSelect @parameter.inner<cr>"_c', "Change function parameter" },
	["<a-s>"] = { '<cmd>TSTextobjectSelect @parameter.outer<cr>"_d', "Delete function parameter" },

	["<a-o>"] = { "mao<ESC>`a", "New line in normal mode" },
	["<a-O>"] = { "maO<ESC>`a", "New line before in normal mode" },

	-- Motions
	["H"] = { "^", "[MOTION] Move to first character of line" },
	["L"] = { "$", "[MOTION] Move to last character of line" },
	["W"] = { "<cmd>lua require('spider').motion('w')<cr>", "[MOTION] Spider-w motion" },
	["B"] = { "<cmd>lua require('spider').motion('b')<cr>", "[MOTION] Spider-b motion" },
	["E"] = { "<cmd>lua require('spider').motion('e')<cr>", "[MOTION] Spider-e motion" },
	["gE"] = { "<cmd>lua require('spider').motion('ge')<cr>", "[MOTION] Spider-ge motion" },

	---- Following remaps conflict with Neoscroll plugin for scrolling animations
	["<c-d>"] = { "<c-d>zz", "Keep cursor in the middle while scrolling down" },
	["<c-u>"] = { "<c-u>zz", "Keep cursor in the middle while scrolling up" },
	----
	["n"] = { "nzz", "Keep searching result in the middle" },
	["N"] = { "Nzz", "Keep searching result in the middle" },

	["<a-down>"] = { "<cmd>TSTextobjectGotoNextStart @function.outer<cr>", "[MOTION] Move to next method" },
	["<a-up>"] = { "<cmd>TSTextobjectGotoPreviousStart @function.outer<cr>", "[MOTION] Move to previous method" },

	-- Window navigation
	---- Without bufferline
	-- ["<a-right>"] = { "<cmd>bn<cr>", "[BUFFER] Go previous buffer" },
	-- ["<a-left>"] = {d"<cmd>bp<cr>", "[BUFFER] Go next buffer" },
	-- With bufferline
	["<a-h>"] = { "<cmd>BufferLineCyclePrev<cr>", "[BUFFER] Go previous buffer" },
	["<a-l>"] = { "<cmd>BufferLineCycleNext<cr>", "[BUFFER] Go next buffer" },
	["<a-b>"] = { "<cmd>e #<cr>", "[BUFFER] Switch to other buffer" },
	["<a-t>"] = { "<cmd>ene<cr>", "[BUFFER] Open a new empty buffer" },
	["Z"] = { "<cmd>wall<cr>", "[BUFFER] Save all" },
	["Q"] = { "<cmd>qall!<cr>", "[BUFFER] Quit all without saving" },
	-- Using famiu/bufdelete.nvim plugin commands to prevent messy behaviours with other plugins
	["<a-q>"] = { "<cmd>Bdelete!<cr>", "[BUFFER] Close current buffer" },
	["<a-w>"] = { "<cmd>%bd!|e#|bd#<cr>", "[BUFFER] Close other buffers" },
	-- Folds
	["|"] = { "za", "[FOLDS] Toggle fold" },
	["--"] = { "zA", "[FOLDS] Toggle all folds" },
	["<a-s-down>"] = { "zr", "[FOLDS] Increase fold level" },
	["<a-s-up>"] = { "zm", "[FOLDS] Decrease fold level" },
	-- ["<a-down>"] = { "zo", "[FOLDS] Open fold" },
	-- ["<a-up>"] = { "zc", "[FOLDS] Close fold" },

	-- Macros and registers
	["t"] = { '"_', "Set black hole registry" },
	["qj"] = { "@q", "Execute macro saved in 'q' register" },

	-- Find
	[";;"] = { "<cmd>noh<cr>", "Clean search highlights" },
	["<leader>f"] = {
		name = "[TELESCOPE]",
		e = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "[TELESCOPE] Find File" },
		n = { "<cmd>Telescope grep_string<cr>", "[TELESCOPE] Find files using grep in file names" },
		g = { "<cmd>Telescope live_grep<cr>", "[TELESCOPE] Find File by live grep (search content inside file)" },
		b = { "<cmd>Telescope buffers<cr>", "[TELESCOPE] Find buffers" },
		m = { "<cmd>Telescope marks<cr>", "[TELESCOPE] Marks" },
		h = { "<cmd>Telescope oldfiles<cr>", "[TELESCOPE] Recent files" },
		d = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "[TELESCOPE] Current buffer fuzzy find" },
		t = { "<cmd>TodoTelescope<cr>", "[TELESCOPE] TODO list" },
		c = { "<cmd>Telescope command_history<cr>", "[TELESCOPE] Search command history" },
		x = { "<cmd>Telescope neoclip<cr>", "[TELESCOPE] Search in clipboard manager" },
		p = { "<cmd>Telescope projects<cr>", "[TELESCOPE] Search projects" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "[TELESCOPE LSP] Find symbols" },
		z = { "<cmd>Telescope zoxide list<cr>", "[TELESCOPE] Zoxide" },
		f = { "<cmd>Telescope frecency<cr>", "[TELESCOPE] Frecency" },
		ic = { "<cmd>Telescope git_commits<cr>", "[TELESCOPE] Git commits" },
		ib = { "<cmd>Telescope git_branches<cr>", "[TELESCOPE] Git branches" },
		is = { "<cmd>Telescope git_status<cr>", "[TELESCOPE] Git status" },
		ih = { "<cmd>Telescope git_stash<cr>", "[TELESCOPE] Git stash" },
	},

	-- Views
	["<leader>v"] = {
		name = "[Views]",
		f = { "<cmd>NeoTreeFocusToggle<cr>", "[NEOTREE] Toggle file tree view" },
		p = { "<cmd>TroubleToggle<cr>", "[TROUBLE] Toggle problem and diagnostics view" },
		s = { "<cmd>AerialToggle<cr>", "[AERIAL] Toggle file structure view" },
		t = { "<cmd>ToggleTerm<cr>", "[TOGGLETERM] Open new terminal" },
		u = { "<cmd>UndotreeToggle<cr>", "[UNDOTREE]Toggle last undoable changes view" },
	},

	-- Debug
	["<leader>d"] = {
		name = "[DAP debug]",
		R = { "<cmd>lua require'dap'.run()<cr>", "[DAP] Run" },
		e = { "<cmd>lua require'dap'.run_last()<cr>", "[DAP] Debug last" },
		E = { "<cmd>Telescope dap configurations<cr>", "[DAP] Show debug configurations" },
		k = { "<cmd>DapTerminate<cr>", "[DAP] Terminate" },
		b = { "<cmd>DapToggleBreakpoint<cr>", "[DAP] Toggle breakpoint" },
		B = {
			"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
			"[DAP] Set conditional breakpoint",
		},
		l = {
			"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
			"[DAP] Set log point breakpoint",
		},
		c = { "<cmd>DapContinue<cr>", "[DAP] Continue" },
		v = { "<cmd>DapStepOver<cr>", "[DAP] Step over" },
		i = { "<cmd>DapStepInto<cr>", "[DAP] Step into" },
		o = { "<cmd>DapStepOut<cr>", "[DAP] Step out" },
		x = { "<cmd>lua require('dapui').eval()<cr>", "[DAPUI] Evaluate}" },
		p = { "<cmd>DapToggleRepl<cr>", "[DAP] Repl open" },
		u = { "<cmd>lua require'dapui'.toggle()<cr>", "[DAPUI] Toggle debugging UI" },
		s = { "<cmd>Telescope dap list_breakpoints<cr>", "[TELESCOPE DAP] Show all breakpoints" },
		w = { "<cmd>Telescope dap variables<cr>", "[TELESCOPE DAP] Wariables" },
	},

	-- Code navigation
	["<leader>c"] = {
		name = "[Code navigation]",
		l = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "[LSP] Go to declaration" },
		d = { "<cmd>Glance definitions<cr>", "[LSP] Go to definition" },
		-- d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "[LSP] Go to definition" },
		t = { "<cmd>Glance type_definitions<cr>", "[LSP] Go to type definition" },
		-- t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "[LSP] Go to type definition" },
		i = { "<cmd>Telescope lsp_implementations<cr>", "[LSP] Go to implementation" },
		-- i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "[LSP] Go to implementation" },
		s = { "<cmd>lua require'jdtls'.super_implementation()<cr>", "[JDLTS] Go to super implementation" },
		r = { "<cmd>Telescope lsp_references<cr>", "[LSP] Go to references" },
		-- r = { "<cmd>lua vim.lsp.buf.references()<cr>", "[LSP] Go to references" },
		v = { "<cmd>Lspsaga hover_doc<cr>", "[LSP] Hover" },
		c = { "<cmd>Telescope lsp_incoming_calls<cr>", "[LSP] Show incoming calls" },
		h = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "[LSP] Signature help" },
		x = {
			"<cmd>lua require'telescope.builtin'.treesitter{ symbols = {'method', 'function'}}<cr>",
			"[TELESCOPE] Get current buffer functions",
		},
	},

	-- Refactoring
	["<leader>r"] = {
		name = "[Code refactor]",
		e = { "<cmd>Lspsaga code_action<cr>", "[LSP] Code actions" },
		f = { "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<cr>", "[CONFORM] Format code" },
		n = { "<cmd>Lspsaga rename<cr>", "[LSP] Rename" },
		i = { "<cmd>:Refactor inline_var <cr>", "[REFACTOR] Inline variable" },
		I = { "<cmd>:Refactor inline_func <cr>", "[REFACTOR] Inline function" },
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
		d = { "<cmd>Gitsigns diffthis<cr>", "[GIT] Diff" },
		n = { "<cmd>Gitsigns next_hunk<cr>", "[GIT] Next hunk" },
		p = { "<cmd>Gitsigns prev_hunk<cr>", "[GIT] Prev hunk" },
		h = { "<cmd>Gitsigns preview_hunk<cr>", "[GIT] Preview hunk" },
	},
	-- Display modes
	["<leader>m"] = {
		name = "[Display modes]",
		z = { "<cmd>ZenMode<cr>", "[MODE] Toggle zen mode" },
	},

	-- Jumps/Marks
	["<leader>j"] = {
		name = "[Jumps]",
		k = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "[HARPOON] Show quick menu" },
		a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "[HARPOON] Add file" },
	},
}, n_opts)

-- INSERT MODE MAPPINGS
local i_opts = {
	mode = "i",
	prefix = "",
	silent = true,
	noremap = true,
	nowait = true,
}

wk.add({
	["jk"] = { "<Esc>", "Normal mode switch" },
	["<a-s>"] = { "<Del>", "Handy DEL on insert mode" },
	["<a-d>"] = { '<C-o>"_diw', "Delete word" },
	["<a-c>"] = { '<C-o>"_ciw', "Change word" },
	["<a-w>"] = { "<C-o>w", "Move to next word" },
	["<a-b>"] = { "<C-o>b", "Move to previous word" },
	["<a-e>"] = { "<ESC>ea", "Move to end of word" },
	["<a-j>"] = { "<ESC>:m .+1<cr>==gi", "[MOVE] Move block down" },
	["<a-k>"] = { "<ESC>:m .-2<cr>==gi", "[MOVE] Move block up" },
}, i_opts)

-- VISUAL MODE MAPPINGS
local v_opts = {
	mode = "v",
	nowait = true,
	prefix = "",
	silent = true,
	noremap = true,
}
wk.add({
	["jk"] = { "<Esc>", "Normal mode switch" },
	["<c-s>"] = { "ggOG", "[SELECT] Select all" },
	["v"] = { "^o$", "[SELECT] Select trimmed line" },
	-- Edit
	["c"] = { '"_c', "Do not copy when changing" },
	["C"] = { '"_C', "Do not copy when changing" },
	["cc"] = { '"_cc', "Do not copy when changing" },
	["p"] = { '"_dP', "Paste without replacing what is was in clipboard" },
	["<a-j>"] = { ":m '>+1<cr>gv=gv", "[MOVE] Move block down" },
	["<a-k>"] = { ":m '<-2<cr>gv=gv", "[MOVE] Move block up" },
	-- Motions
	["H"] = { "^", "[MOTION] Move to first character of line" },
	["L"] = { "$", "[MOTION] Move to last character of line" },
	["<a-down>"] = { "<cmd>TSTextobjectGotoNextStart @function.outer<cr>", "[MOTION] Move to next method" },
	["<a-up>"] = { "<cmd>TSTextobjectGotoPreviousStart @function.outer<cr>", "[MOTION] Move to previous method" },
	["w"] = { "<cmd>lua require('spider').motion('w')<cr>", "[MOTION] Spider-w motion" },
	["e"] = { "<cmd>lua require('spider').motion('e')<cr>", "[MOTION] Spider-e motion" },
	["b"] = { "<cmd>lua require('spider').motion('b')<cr>", "[MOTION] Spider-b motion" },
	["E"] = { "<cmd>lua require('spider').motion('ge')<cr>", "[MOTION] Spider-ge motion" },

	["<"] = { "<gv", "[Indent] Indent left" },
	[">"] = { ">gv", "[Indent] Indent right" },
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
wk.add({
	["<a-Bs>"] = { "<C-o>diw", "Delete word" },
	["<a-c>"] = { "<C-o>ciw", "Change word" },
}, s_opts)

-- Execution mode mappings
local x_opts = {
	mode = "x",
	prefix = "",
	silent = true,
	noremap = true,
	nowait = true,
}
wk.add({
	["<leader>r"] = {
		name = "[Code refactor]",
		v = { "<cmd>:Refactor extract_var <cr>", "[REFACTOR] Extract variable" },
		x = { "<cmd>:Refactor extract <cr>", "[REFACTOR] Extract function" },
		l = { "<cmdr:Refactor extract_to_file <cr>", "[REFACTOR] Extract to file" },
	},
}, x_opts)

-- Terminal mode mappings
local t_opts = {
	mode = "t",
	prefix = "",
	silent = true,
	noremap = true,
	nowait = true,
}
wk.add({
	["<c-h>"] = { "<cmd>wincmd h<cr>,", "[TERMINAL] Move left" },
	["<c-j>"] = { "<cmd>wincmd j<cr>,", "[TERMINAL] Move down" },
	["<c-k>"] = { "<cmd>wincmd k<cr>,", "[TERMINAL] Move up" },
	["<c-l>"] = { "<cmd>wincmd l<cr>,", "[TERMINAL] Move right" },
}, t_opts)

wk.setup({})
