local ok, wk = pcall(require, "which-key")

if not ok then
	return
end

-- Returns an expr callback for a nvim-spider motion. On very long lines it falls back to the native motion:
-- spider copies the whole line into Lua on every key, which takes seconds on minified files or logs
local function spider_motion(motion)
	return function()
		if vim.fn.col("$") > 10000 then
			return motion
		end
		return "<cmd>lua require('spider').motion('" .. motion .. "')<cr>"
	end
end

-- Returns a callback that jumps to the next (1) or previous (-1) diagnostic and shows it in a floating window
local function diagnostic_jump(count)
	return function()
		vim.diagnostic.jump({
			count = count,
			on_jump = function(_, bufnr)
				vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
			end,
		})
	end
end

-- Returns a callback for Visual +/_ that uses Neovim's an/in (node_keys) where a treesitter parser or an LSP
-- selection range is available, and vim-expand-region (fallback <Plug> keys) elsewhere
local function selection_step(node_keys, fallback)
	return function()
		local count = vim.v.count1
		local parser = vim.treesitter.get_parser(0, nil, { error = false })
		if parser or #vim.lsp.get_clients({ bufnr = 0, method = "textDocument/selectionRange" }) > 0 then
			vim.cmd.normal(count .. node_keys)
		else
			vim.cmd.normal(vim.keycode(fallback):rep(count))
		end
	end
end

-- Returns the first line of the Visual selection, to pre-fill Telescope prompts
local function visual_text()
	return vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })[1] or ""
end

-- MULTIPLE MODES MAPPINGS
wk.add({
	mode = { "n", "x", "o" },
	{ "H", "^", desc = "[MOTION] Move to first character of line" },
	{ "L", "$", desc = "[MOTION] Move to last character of line" },
	{ "gE", spider_motion("ge"), expr = true, desc = "[MOTION] Spider-ge motion" },
	{ "B", spider_motion("b"), expr = true, desc = "[MOTION] Spider-b motion" },
	{ "E", spider_motion("e"), expr = true, desc = "[MOTION] Spider-e motion" },
	{ "W", spider_motion("w"), expr = true, desc = "[MOTION] Spider-w motion" },
})

-- NORMAL MODE MAPPINGS
wk.add({
	{ ",", "@:", desc = "[RUN] Repeat last command" },
	-- Edition
	{ "<c-s>", "ggVG", desc = "[SELECT] Select all" },
	{
		"+",
		function()
			-- <Esc> drops the count, which would change what v selects; Visual + then expands count times
			return "<Esc>v" .. ("+"):rep(vim.v.count1)
		end,
		expr = true,
		remap = true,
		desc = "[SELECT] Start selection and expand it",
	},
	-- {"d", '"_d',desc= "Do not copy when deleting" },
	-- {"D", '"_D',desc= "Do not copy when deleting" },
	-- {"dd", '"_dd',desc= "Do not copy when deleting" },
	{ "c", '"_c', desc = "Do not copy when changing" },
	{ "C", '"_C', desc = "Do not copy when changing" },

	{
		"<a-s-p>",
		'<cmd>lua require("various-textobjs").anyBracket("inner")<cr>"_dP',
		desc = "Replace block content with paste",
	},
	{ "<a-p>", "VP", desc = "Replace line with paste" },
	{ "gs", '<cmd>lua require("substitute").operator()<cr>', desc = "Replace operator with paste" },
	{ "gss", '<cmd>lua require("substitute").line()<cr>', desc = "Replace line with paste" },

	{ "<a-j>", ":m .+1<cr>==", desc = "Move line down" },
	{ "<a-k>", ":m .-2<cr>==", desc = "Move line up" },

	{ "<a-d>", '"_diw', desc = "Delete word" },
	{ "<a-s-d>", '<cmd>lua require("various-textobjs").subword("inner")<cr>"_d', desc = "Delete subword" },
	{ "<a-c>", '"_ciw', desc = "Change word" },
	{ "<a-s-c>", '<cmd>lua require("various-textobjs").subword("inner")<cr>"_c', desc = "Change subword" },
	{
		"<a-z>",
		'<cmd>lua require("various-textobjs").anyQuote("inner")<cr>"_c',
		desc = "Change within any kind of quotes",
	},
	{
		"<a-s-z>",
		'<cmd>lua require("various-textobjs").anyQuote("inner")<cr>"_d',
		desc = "Delete within any kind of quotes",
	},
	{
		"<a-x>",
		'<cmd>lua require("various-textobjs").anyBracket("inner")<cr>"_c',
		desc = "Change within any kind of bracket (),[],{}",
	},
	{
		"<a-s-x>",
		'<cmd>lua require("various-textobjs").anyBracket("inner")<cr>"_d',
		desc = "Delete within any kind of bracket (),[],{}",
	},

	-- ia/aa are the treesitter parameter textobjects
	{ "<a-a>", '"_cia', remap = true, desc = "Change function parameter" },
	{ "<a-s>", '"_daa', remap = true, desc = "Delete function parameter" },

	-- Neovim's ]<Space>/[<Space> add [count] blank lines without moving the cursor or setting marks, and repeat with .
	{ "<a-o>", "]<Space>", remap = true, desc = "New line in normal mode" },
	{ "<a-O>", "[<Space>", remap = true, desc = "New line before in normal mode" },

	---- Following remaps conflict with Neoscroll plugin for scrolling animations
	{ "<c-d>", "<c-d>zz", desc = "Keep cursor in the middle while scrolling down" },
	{ "<c-u>", "<c-u>zz", desc = "Keep cursor in the middle while scrolling up" },
	----
	{ "n", "nzz", desc = "Keep searching result in the middle" },
	{ "N", "Nzz", desc = "Keep searching result in the middle" },

	-- ]m/[m are the treesitter method motions in buffers with a parser, Vim's builtin ones elsewhere
	{ "<a-down>", "]m", mode = { "n", "x" }, remap = true, desc = "[MOTION] Move to next method" },
	{ "<a-up>", "[m", mode = { "n", "x" }, remap = true, desc = "[MOTION] Move to previous method" },

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
	---- Using nvim-mini/mini.bufremove (also bufferline's close_command) to prevent messy behaviours with other plugins
	{ "<a-q>", "<cmd>lua require('mini.bufremove').delete(0, false)<cr>", desc = "[BUFFER] Close current buffer" },
	{ "<a-w>", "<cmd>BufferLineCloseOthers<cr>", desc = "[BUFFER] Close other buffers" },

	-- Windows (resize/focus heads come from the hydra)
	{ "<leader>w", group = "Windows" },
	{ "<leader>wn", "<cmd>set relativenumber!<cr>", desc = "[VIEW] Toggle relative numbers" },

	{ "qj", "@q", desc = "Execute macro saved in 'q' register" },

	-- Find
	{ ";", "<cmd>noh<cr>", desc = "Clean search highlights" },
	{ "<leader>f", group = "Find" },
	{ "<leader>fe", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", desc = "[TELESCOPE] Find File" },
	{
		"<leader>fn",
		"<cmd>Telescope grep_string<cr>",
		mode = { "n", "x" },
		desc = "[TELESCOPE] Grep word under cursor or selection",
	},
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
	{ "<leader>fk", "<cmd>Telescope dap list_breakpoints<cr>", desc = "[TELESCOPE DAP] Show all breakpoints" },
	{ "<leader>fic", "<cmd>Telescope git_commits<cr>", desc = "[TELESCOPE] Git commits" },
	{ "<leader>fib", "<cmd>Telescope git_branches<cr>", desc = "[TELESCOPE] Git branches" },
	{ "<leader>fis", "<cmd>Telescope git_status<cr>", desc = "[TELESCOPE] Git status" },
	{ "<leader>fih", "<cmd>Telescope git_stash<cr>", desc = "[TELESCOPE] Git stash" },

	-- Views
	{ "<leader>v", group = "Views" },
	{ "<leader>vf", "<cmd>Neotree toggle<cr>", desc = "[NEOTREE] Toggle file tree view" },
	{ "<leader>vp", "<cmd>Trouble diagnostics toggle<cr>", desc = "[TROUBLE] Toggle problem and diagnostics view" },
	{ "<leader>vs", "<cmd>AerialToggle<cr>", desc = "[AERIAL] Toggle file structure view" },
	-- A count picks the terminal (2<leader>vt); without one, the last used terminals are toggled
	{ "<leader>vt", "<cmd>lua require('toggleterm').toggle(vim.v.count)<cr>", desc = "[TOGGLETERM] Toggle terminal" },
	{ "<leader>vu", "<cmd>Undotree<cr>", desc = "[UNDOTREE] Toggle undo tree view" },
	{ "<leader>vi", "<cmd>InspectTree<cr>", desc = "[TREESITTER] Inspect tree" },

	-- Debug
	{ "<leader>d", group = "Debug" },
	{ "<leader>dR", "<cmd>DapNew<cr>", desc = "[DAP] New debug session" },
	{ "<leader>de", "<cmd>lua require'dap'.run_last()<cr>", desc = "[DAP] Debug last" },
	{ "<leader>dE", "<cmd>Telescope dap configurations<cr>", desc = "[DAP] Show debug configurations" },
	{ "<leader>dk", "<cmd>DapTerminate<cr>", desc = "[DAP] Terminate" },
	{ "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "[DAP] Toggle breakpoint" },
	{
		"<leader>dB",
		"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
		desc = "[DAP] Set conditional breakpoint",
	},
	{
		"<leader>dl",
		"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
		desc = "[DAP] Set log point breakpoint",
	},
	{ "<leader>dc", "<cmd>DapContinue<cr>", desc = "[DAP] Continue" },
	{ "<leader>dv", "<cmd>DapStepOver<cr>", desc = "[DAP] Step oVer" },
	{ "<leader>di", "<cmd>DapStepInto<cr>", desc = "[DAP] Step Into" },
	{ "<leader>do", "<cmd>DapStepOut<cr>", desc = "[DAP] Step Out" },
	{ "<leader>dx", "<cmd>lua require('dapui').eval()<cr>", desc = "[DAPUI] Evaluate expression" },
	{ "<leader>dp", "<cmd>DapToggleRepl<cr>", desc = "[DAP] Repl open" },
	{ "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", desc = "[DAPUI] Toggle debugging UI" },
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
	{ "<leader>cr", "<cmd>Telescope lsp_references<cr>", desc = "[LSP] Go to references" },
	-- {"<leader>cr", "<cmd>lua vim.lsp.buf.references()<cr>", desc= "[LSP] Go to references" },
	{ "<leader>cv", "<cmd>Lspsaga hover_doc<cr>", desc = "[LSP] Hover" },
	{ "<leader>cc", "<cmd>Telescope lsp_incoming_calls<cr>", desc = "[LSP] Show incoming Calls" },
	{ "<leader>ch", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "[LSP] Signature Help" },
	{
		"<leader>cx",
		"<cmd>lua require'telescope.builtin'.treesitter{ symbols = {'method', 'function', 'function_definition', 'function_declaration'}}<cr>",
		desc = "[TELESCOPE] Get current buffer functions",
	},

	-- Refactoring
	{ "<leader>r", group = "[Code Refactor]", mode = { "n", "x" } },
	-- Extract/inline refactors are code actions of the language servers (jdtls, rust-analyzer...),
	-- in Visual mode they apply to the selection
	{ "<leader>re", "<cmd>Lspsaga code_action<cr>", mode = { "n", "x" }, desc = "[LSP] Code actions and refactors" },
	{
		"<leader>rf",
		"<cmd>lua require('conform').format({ async = true, lsp_format = 'fallback' })<cr>",
		desc = "[CONFORM] Format code",
	},
	{ "<leader>rn", "<cmd>Lspsaga rename<cr>", desc = "[LSP] Rename" },

	-- Errors and diagnostics
	{ "<leader>e", group = "[Errors and diagnostics]" },
	{ "<leader>en", diagnostic_jump(1), desc = "[DIAG] Go to next error" },
	{ "<leader>ep", diagnostic_jump(-1), desc = "[DIAG] Go to previous error" },

	-- Git
	{ "<leader>g", group = "[GIT]" },
	{ "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "[GIT] Diff" },
	{ "<leader>gn", "<cmd>Gitsigns nav_hunk next<cr>", desc = "[GIT] Next hunk" },
	{ "<leader>gp", "<cmd>Gitsigns nav_hunk prev<cr>", desc = "[GIT] Prev hunk" },
	{ "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>", desc = "[GIT] Preview hunk" },

	-- Folds (heads come from the hydra) and display modes
	{ "<leader>z", group = "[Folds and display modes]" },
	{ "<leader>zz", "<cmd>ZenMode<cr>", desc = "[MODE] Toggle zen mode" },
})

-- INSERT MODE MAPPINGS
wk.add({
	mode = { "i" },
	{ "jk", "<Esc>", desc = "Normal mode switch" },
	{ "<a-s>", "<Del>", desc = "Handy DEL on insert mode" },
	{ "<a-c>", '<ESC>"_ciw', desc = "Change word" },
	{ "<a-s-c>", '<ESC><cmd>lua require("various-textobjs").subword("inner")<cr>"_c', desc = "Change subword" },
	{
		"<a-z>",
		'<ESC><cmd>lua require("various-textobjs").anyQuote("inner")<cr>"_c',
		desc = "Change within any kind of quotes",
	},
	{
		"<a-x>",
		'<ESC><cmd>lua require("various-textobjs").anyBracket("inner")<cr>"_c',
		desc = "Change within any kind of bracket (),[],{}",
	},
	{ "<a-w>", "<C-o>w", desc = "Move to next word" },
	{ "<a-b>", "<C-o>b", desc = "Move to previous word" },
	{ "<a-e>", "<ESC>ea", desc = "Move to end of word" },
	{ "<a-j>", "<ESC>:m .+1<cr>==gi", desc = "[MOVE] Move block down" },
	{ "<a-k>", "<ESC>:m .-2<cr>==gi", desc = "[MOVE] Move block up" },
})

-- VISUAL MODE MAPPINGS
wk.add({
	mode = { "x" },
	{ "jk", "<Esc>", desc = "Normal mode switch" },
	{ "<c-s>", "<Esc>ggVG", desc = "[SELECT] Select all" },
	{ "v", "^o$", desc = "[SELECT] Select trimmed line" },
	-- Neovim's an/in (treesitter nodes, else LSP selection ranges), vim-expand-region in buffers that have neither
	{
		"+",
		selection_step("an", "<Plug>(expand-region-grow)"),
		desc = "[SELECT] Expand selection to parent node or text object",
	},
	{
		"_",
		selection_step("in", "<Plug>(expand-region-shrink)"),
		desc = "[SELECT] Shrink selection to child node or back",
	},

	-- Telescope prompts pre-filled with the selection
	{
		"<leader>fd",
		function()
			require("telescope.builtin").current_buffer_fuzzy_find({ default_text = visual_text() })
		end,
		desc = "[TELESCOPE] Current buffer fuzzy find with selection",
	},
	{
		"<leader>fg",
		function()
			-- live_grep's prompt is a ripgrep regex: escape the selection so it matches literally
			local text = visual_text():gsub("[\\.%*%+%?%^%$%(%)%[%]{}|]", "\\%0")
			require("telescope.builtin").live_grep({ default_text = text })
		end,
		desc = "[TELESCOPE] Live grep with selection",
	},

	-- Edit
	{ "C", '"_C', desc = "Do not copy when changing" },
	{ "c", '"_c', desc = "Do not copy when changing" },
	{ "p", "P", desc = "Paste without replacing what was in clipboard" },
	{ "<a-j>", ":m '>+1<cr>gv=gv", desc = "[MOVE] Move block down" },
	{ "<a-k>", ":m '<-2<cr>gv=gv", desc = "[MOVE] Move block up" },

	-- Indentation
	{ "<", "<gv", desc = "[Indent] Indent left" },
	{ ">", ">gv", desc = "[Indent] Indent right" },

	-- Debug
	{ "<leader>dx", "<cmd>lua require('dapui').eval()<CR>", desc = "[DAPUI] Evaluate selection" },
})

-- Select mode mappings
wk.add({
	mode = { "s" },
	{ "<a-Bs>", '<Esc>"_diw', desc = "Delete word" },
	{ "<a-c>", '<Esc>"_ciw', desc = "Change word" },
})

-- Terminal mode mappings
wk.add({
	mode = { "t" },
	{ "<c-h>", "<cmd>wincmd h<cr>", desc = "[TERMINAL] Move left" },
	{ "<c-j>", "<cmd>wincmd j<cr>", desc = "[TERMINAL] Move down" },
	{ "<c-k>", "<cmd>wincmd k<cr>", desc = "[TERMINAL] Move up" },
	{ "<c-l>", "<cmd>wincmd l<cr>", desc = "[TERMINAL] Move right" },
})

wk.setup({})
