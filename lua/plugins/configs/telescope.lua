return {
	-- Search engine
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-frecency.nvim",
		"jvgrootveld/telescope-zoxide",
		"nvim-telescope/telescope-dap.nvim",
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			pickers = {
				find_files = {
					hidden = true,
				},
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
				-- Lua patterns: "." and "-" must be escaped with "%"
				file_ignore_patterns = {
					"^%.git/",
					"/%.git/",
					"%.settings/",
					"%.metadata/",
					"target/",
					"node_modules/",
					"%.class$",
					"^dist/",
					"/dist/",
					"%.png$",
					"package%-lock%.json$",
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
				path_display = { "truncate" },
				set_env = { ["COLORTERM"] = "truecolor" },
			},
			extensions = {
				fzf = {},
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
