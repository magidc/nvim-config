return {
	"lervag/vimtex",
	dependencies = {
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/nvim-cmp",
	},
	lazy = false, --we don't want lazy to load vimTex
	-- tag = "v2.15", -- uncomment t pin to a specific release
	init = function()
		-- VimTex configuration goes here, e.g.,
		vim.g.vimtex_view_method = "zathura"
		vim.g.maplocalleader = ","
	end,
}
