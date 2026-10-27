return {
	"nvimdev/lspsaga.nvim",
	cmd = "Lspsaga",
	config = function()
		require("lspsaga").setup({
			lightbulb = {
				enable = false,
			},
			symbol_in_winbar = {
				enable = false,
			},
		})
	end,
}
