return {
	"RRethy/vim-illuminate",
	event = { "BufReadPost", "BufNewFile" },
	lazy = false,
	config = function()
		require("illuminate").configure({
			providers = {
				"lsp",
				"treesitter",
				"regex",
			},
			filetypes_denylist = {
				"NeoTree",
				"toggleterm",
				"TelescopePrompt",
			},

			-- delay: delay in milliseconds
			delay = 200,
			-- large_file_cutoff: number of lines at which to use large_file_config
			-- The `under_cursor` option is disabled when this cutoff is hit
			large_file_cutoff = 500,
			-- large_file_config: config to use for large files (based on large_file_cutoff).
			-- Supports the same keys passed to .configure
			-- If nil, vim-illuminate will be disabled for large files.
			large_file_overrides = nil,
		})
	end,
}
