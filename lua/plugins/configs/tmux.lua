return {
	"aserowy/tmux.nvim",
	event = "VeryLazy",
	config = function()
		require("tmux").setup({
			copy_sync = {
				enable = false,
			},
			navigation = {
				enable_default_keybindings = true,
			},
			resize = {
				enable_default_keybindings = false,
			},
		})
	end,
}
