return {
	"glepnir/lspsaga.nvim",
	branch = "main",
	config = function()
		require("lspsaga").setup({
			code_action_lightbulb = {
				enable = false,
				sign = true,
				enable_in_insert = true,
				sign_priority = 20,
				virtual_text = true,
			},
			symbol_in_winbar = {
				enable = false,
			},
		})
		require("plugins.configs.lspsaga")
	end,
}
