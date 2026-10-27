local parsers = {
	"java",
	"cpp",
	"rust",
	"python",
	"lua",
	"html",
	"json",
	"dockerfile",
	"yaml",
	"css",
	"javascript",
	"typescript",
	"vue",
	"toml",
	"bash",
	"zsh",
	"markdown", -- with markdown_inline, also highlights LSP hover docs
	"markdown_inline",
}

-- Filetypes that keep Vim's indent script (sh: nvim-treesitter's bash indents break heredocs, arrays, continuations)
local indent_disabled = { python = true, css = true, rust = true, sh = true }

local textobjects = {
	{ key = "a", query = "@parameter", name = "argument/parameter" },
	{ key = "b", query = "@block", name = "block" },
	{ key = "m", query = "@function", name = "method" },
	{ key = "c", query = "@class", name = "class" },
	{ key = "y", query = "@conditional", name = "conditional" },
	{ key = "l", query = "@loop", name = "loop" },
}

-- Buffer-local, so that buffers without a parser keep the built-in ]b, ]l, ab, ib...
local function set_textobject_maps(buf)
	local select = require("nvim-treesitter-textobjects.select")
	local move = require("nvim-treesitter-textobjects.move")
	local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

	for _, obj in ipairs(textobjects) do
		local outer, inner = obj.query .. ".outer", obj.query .. ".inner"
		local upper = obj.key:upper()
		-- Arguments/parameters end on the inner part, the rest on the outer one
		local end_query = obj.key == "a" and inner or outer

		vim.keymap.set({ "x", "o" }, "a" .. obj.key, function()
			select.select_textobject(outer, "textobjects")
		end, { buf = buf, desc = "Select outer part of a " .. obj.name })
		vim.keymap.set({ "x", "o" }, "i" .. obj.key, function()
			select.select_textobject(inner, "textobjects")
		end, { buf = buf, desc = "Select inner part of a " .. obj.name })

		vim.keymap.set({ "n", "x", "o" }, "]" .. obj.key, function()
			move.goto_next_start(outer, "textobjects")
		end, { buf = buf, desc = "Next " .. obj.name .. " start" })
		vim.keymap.set({ "n", "x", "o" }, "]" .. upper, function()
			move.goto_next_end(end_query, "textobjects")
		end, { buf = buf, desc = "Next " .. obj.name .. " end" })
		vim.keymap.set({ "n", "x", "o" }, "[" .. obj.key, function()
			move.goto_previous_start(outer, "textobjects")
		end, { buf = buf, desc = "Previous " .. obj.name .. " start" })
		vim.keymap.set({ "n", "x", "o" }, "[" .. upper, function()
			move.goto_previous_end(end_query, "textobjects")
		end, { buf = buf, desc = "Previous " .. obj.name .. " end" })
	end

	-- In diff windows ]c/[c keep jumping to the next/previous change
	local class_move = "<Cmd>lua require('nvim-treesitter-textobjects.move').%s('@class.outer', 'textobjects')<CR>"
	vim.keymap.set({ "n", "x", "o" }, "]c", function()
		return vim.wo.diff and "]c" or class_move:format("goto_next_start")
	end, { buf = buf, expr = true, desc = "Next class start or diff change" })
	vim.keymap.set({ "n", "x", "o" }, "[c", function()
		return vim.wo.diff and "[c" or class_move:format("goto_previous_start")
	end, { buf = buf, expr = true, desc = "Previous class start or diff change" })

	-- Repeat the last treesitter move (; and , are :noh and @:, see mappings.lua)
	vim.keymap.set({ "n", "x", "o" }, "<M-;>", ts_repeat_move.repeat_last_move, {
		buf = buf,
		desc = "Repeat last treesitter move",
	})
	vim.keymap.set({ "n", "x", "o" }, "<M-,>", ts_repeat_move.repeat_last_move_opposite, {
		buf = buf,
		desc = "Repeat last treesitter move backwards",
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false, -- main branch does not support lazy-loading
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			branch = "main",
			init = function()
				-- Disable the python/rust ftplugin maps (]m, [[, ...) that would shadow the textobject and usage ones
				vim.g.no_python_maps = true
				vim.g.no_rust_maps = true
			end,
		},
		"windwp/nvim-ts-autotag",
		"andymass/vim-matchup",
	},
	build = ":TSUpdate",
	opts = { ensure_installed = parsers }, -- read by install_nvim.sh
	config = function(_, opts)
		require("nvim-treesitter").install(opts.ensure_installed)

		-- The main branch has no modules: highlighting, indentation and textobjects are set up per buffer
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
			callback = function(args)
				-- Set by bigfile.nvim in BufReadPre (its "treesitter" feature only patches the master branch)
				if vim.b[args.buf].bigfile_disable_treesitter == 1 then
					return
				end
				local lang = vim.treesitter.language.get_lang(args.match)
				if not lang or not pcall(vim.treesitter.start, args.buf, lang) then
					return
				end
				-- Without an indents query, nvim-treesitter's indentexpr puts every line at column 0
				if not indent_disabled[args.match] and #vim.treesitter.query.get_files(lang, "indents") > 0 then
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				elseif args.match == "sh" or args.match == "zsh" then
					-- indent/sh.vim finds heredocs, comments and strings through regex syntax groups
					vim.bo[args.buf].syntax = "ON"
				end
				if #vim.treesitter.query.get_files(lang, "textobjects") > 0 then
					set_textobject_maps(args.buf)
				end
			end,
		})

		require("nvim-ts-autotag").setup()

		-- Textobjects
		require("nvim-treesitter-textobjects").setup({ select = { lookahead = true } })

		-- Usage navigation via vim-illuminate: LSP documentHighlight when a server is attached, otherwise word matches
		vim.keymap.set("n", "]]", function()
			require("illuminate").goto_next_reference(false)
		end, { desc = "Next usage" })
		vim.keymap.set("n", "[[", function()
			require("illuminate").goto_prev_reference(false)
		end, { desc = "Previous usage" })
	end,
}
