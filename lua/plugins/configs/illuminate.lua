return {
	"RRethy/vim-illuminate",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("illuminate").configure({
			-- No "treesitter" provider: it needs nvim-treesitter's locals module, which the main branch does not have
			providers = {
				"lsp",
				"regex",
			},
			filetypes_denylist = {
				"neo-tree",
				"neo-tree-popup",
				"toggleterm",
				"TelescopePrompt",
			},

			-- delay: delay in milliseconds
			delay = 100,
			-- large_file_cutoff: number of lines at which to use large_file_overrides
			large_file_cutoff = 10000,
			-- large_file_overrides: config to use for large files (based on large_file_cutoff).
			-- Supports the same keys passed to .configure
			-- If nil, vim-illuminate will be disabled for large files (and ]]/[[ with it).
			large_file_overrides = nil,
		})
		-- plugin/illuminate.vim maps <a-n>/<a-p> before this runs, too early for disable_keymaps.
		-- <a-p> is "Replace line with paste" (mappings.lua) and references are on ]]/[[ (treesitter.lua)
		pcall(vim.keymap.del, "n", "<a-n>")
	end,
}
