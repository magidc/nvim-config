return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"p00f/nvim-ts-rainbow", -- Open/Close node coloring
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/playground", -- View treesitter information directly in Neovim
	},
	build = ":TSUpdate",
	config = function()
		local colors = require("theme").colors

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
			},
			highlight = {
				enable = false,
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
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
						["am"] = "@function.outer",
						["im"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]["] = "@class.outer",
						["]a"] = "@parameter.outer",
						["]b"] = "@block.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]]"] = "@class.outer",
						["]A"] = "@parameter.outer",
						["]B"] = "@block.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
						["[a"] = "@parameter.outer",
						["[b"] = "@block.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
						["[A"] = "@parameter.outer",
						["[B"] = "@block.outer",
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
			-- incremental_selection = {
			--     enable = true,
			--     keymaps = {
			--         init_selection = "+", -- set to `false` to disable one of the mappings
			--         node_incremental = "+",
			--         scope_incremental = "grc",
			--         node_decremental = "_",
			--     },
			-- },
		})
	end,
}
