return {
	-- Search engine
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-frecency.nvim",
		"jvgrootveld/telescope-zoxide",
		"nvim-telescope/telescope.nvim",
		"nvim-telescope/telescope-dap.nvim",
	},
	config = function()
		telescope = require("telescope")
		telescope.setup({
			picker = {
				hidden = true,
			},
			defaults = {
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--no-ignore",
					"--smart-case",
					"--hidden",
				},
				file_ignore_patterns = {
					".git/",
					".settings/",
					".metadata/",
					"target/",
					"node_modules/",
					".class$",
					"dist/",
					".png",
					"package-lock.json",
				},
				mappings = {
					i = {
						["<C-u>"] = false,
						["<C-d>"] = false,
					},
				},
				layout_strategy = "horizontal",
				layout_config = {
					--   width = 0.5,
					--   height = 0.4,
					preview_cutoff = 120,
				},
				prompt_prefix = "   ",
				file_sorter = require("telescope.sorters").get_fuzzy_file,
				generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
				path_display = { "truncate" },
				color_devicons = true,
				use_less = true,
				set_env = { ["COLORTERM"] = "truecolor" },
				file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				frecency = {
					default_workspace = "CWD",
					show_scores = true,
					show_unindexed = true,
					disable_devicons = false,
					ignore_patterns = {
						"*.git/*",
						"*/tmp/*",
						"*/lua-language-server/*",
					},
				},
			},
		})
		telescope.load_extension("fzf")
		telescope.load_extension("frecency")
		telescope.load_extension("zoxide")
		telescope.load_extension("dap")
	end,
}
