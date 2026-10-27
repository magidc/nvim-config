return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local signs = {
			add = {
				text = "+",
			},
			change = {
				text = "~",
			},
			delete = {
				text = "_",
			},
			topdelete = {
				text = "‾",
			},
			changedelete = {
				text = "~",
			},
		}
		require("gitsigns").setup({
			signs = signs,
			-- Staged hunks use the same glyphs, told apart by their GitSignsStaged* colors
			signs_staged = signs,
		})
	end,
}
