return {
	-- Autoclose brackets, parentheses...
	"windwp/nvim-autopairs",
	config = function()
		require("nvim-autopairs").setup()
	end,
}
