return {
	"nvimdev/lspsaga.nvim",
	config = function()
		require("lspsaga").setup({
			lightbulb = {
				enable = false,
				sign = true,
				debounce = 10,
				virtual_text = true,
				sign_priority = 40
			},
		})
	end,
}
