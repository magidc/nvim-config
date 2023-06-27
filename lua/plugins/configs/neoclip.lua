return {
	"AckslD/nvim-neoclip.lua",
	dependencies = "nvim-telescope/telescope.nvim",
	config = function()
		require("neoclip").setup({
			default_register = "+",
		})
        require("telescope").load_extension("neoclip")
	end,
}
