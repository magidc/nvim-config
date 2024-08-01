return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"hiphish/rainbow-delimiters.nvim",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-refactor",
		"nvim-treesitter/playground", -- View treesitter information directly in Neovim
		"andymass/vim-matchup",
	},
	build = ":TSUpdate",
	config = function()
		local colors = require("theme").colors
		local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

		-- vim way: ; goes to the direction you were moving.
		vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
		vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

		require("nvim-treesitter.configs").setup({
			autotag = {
				enable = true,
			},
			indent = {
				enable = true,
				disable = { "python", "css", "rust" },
			},
			--ensure_installed = "all",
			ensure_installed = {
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
                "toml"
			},
			refactor = {
				highlight_definitions = {
					enable = true,
					-- Set to false if you have an `updatetime` of ~100.
					clear_on_cursor_move = true,
				},
				highlight_current_scope = { enable = false },
				navigation = {
					enable = true,
					-- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
					keymaps = {
						goto_definition = false,
						list_definitions = false,
						list_definitions_toc = false,
						goto_next_usage = "]]",
						goto_previous_usage = "[[",
					},
				},
			},
			rainbow = {
				colors = {
					colors.magenta,
					colors.cyan,
					colors.yellow,
					colors.orange,
					colors.red,
					colors.blue,
					colors.green,
				},
				enable = true,
				extended_mode = true,
				max_file_lines = nil,
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["aa"] = { query = "@parameter.outer", desc = "Select outer part of a argument/parameter" },
						["ia"] = { query = "@parameter.inner", desc = "Select inner part of a argument/parameter" },
						["ab"] = { query = "@block.outer", desc = "Select outer part of a block" },
						["ib"] = { query = "@block.inner", desc = "Select inner part of a block" },
						["am"] = { query = "@function.outer", desc = "Select outer part of a method" },
						["im"] = { query = "@function.inner", desc = "Select inner part of a method" },
						["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
						["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
						["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },
						["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
						["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = { query = "@function.outer", desc = "Next method start" },
						["]c"] = { query = "@class.outer", desc = "Next class start" },
						["]a"] = { query = "@parameter.outer", desc = "Next argument/parameter start" },
						["]b"] = { query = "@block.outer", desc = "Next block start" },
						["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
						["]l"] = { query = "@loop.outer", desc = "Next loop start" },
					},
					goto_next_end = {
						["]M"] = { query = "@function.outer", desc = "Next method end" },
						["]C"] = { query = "@class.outer", desc = "Next class end" },
						["]A"] = { query = "@parameter.inner", desc = "Next argument/parameter end" },
						["]B"] = { query = "@block.outer", desc = "Next block end" },
						["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
						["]L"] = { query = "@loop.outer", desc = "Next loop end" },
					},
					goto_previous_start = {
						["[m"] = { query = "@function.outer", desc = "Previous method start" },
						["[c"] = { query = "@class.outer", desc = "Previous class start" },
						["[a"] = { query = "@parameter.outer", desc = "Previous argument/parameter start" },
						["[b"] = { query = "@block.outer", desc = "Previous block start" },
						["[i"] = { query = "@conditional.outer", desc = "Previous conditional start" },
						["[l"] = { query = "@loop.outer", desc = "Previous loop start" },
					},
					goto_previous_end = {
						["[M"] = { query = "@function.outer", desc = "Previous method end" },
						["[C"] = { query = "@class.outer", desc = "Previous class end" },
						["[A"] = { query = "@parameter.inner", desc = "Previous argument/parameter end" },
						["[B"] = { query = "@block.outer", desc = "Previous block end" },
						["[I"] = { query = "@conditional.outer", desc = "Previous conditional end" },
						["[L"] = { query = "@loop.outer", desc = "Previous loop end" },
					},
				},
			},
			playground = {
				enable = true,
				disable = {},
				updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
				persist_queries = false, -- Whether the query persists across vim sessions
				keybindings = {
					toggle_query_editor = "o",
					toggle_hl_groups = "i",
					toggle_injected_languages = "t",
					toggle_anonymous_nodes = "a",
					toggle_language_display = "I",
					focus_language = "f",
					unfocus_language = "F",
					update = "R",
					goto_node = "<cr>",
					show_help = "?",
				},
			},
			matchup = {
				-- enables vim-matchup integration
				enable = true,
				enable_quotes = true,
			},
			-- incremental_selection = {
			--     enable = true,
			--     keymaps = {
			--         init_selection = "grn", -- set to `false` to disable one of the mappings
			--         node_incremental = "grn",
			--         scope_incremental = "grp",
			--         node_decremental = "_",
			--     },
			-- },
		})
	end,
}
