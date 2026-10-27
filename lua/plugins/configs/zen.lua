return {
	"folke/zen-mode.nvim",
	cmd = "ZenMode",
	opts = {
		plugins = {
			twilight = { enabled = false }, -- folke/twilight.nvim is not installed
		},
		-- nvim-scrollbar's floats (zindex 50) would stay drawn over the zen window (zindex 40)
		on_open = function()
			pcall(vim.cmd, "ScrollbarHide")
		end,
		on_close = function()
			pcall(vim.cmd, "ScrollbarShow")
		end,
	},
}
