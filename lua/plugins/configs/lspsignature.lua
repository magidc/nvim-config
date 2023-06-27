return {
	-- Show function signature when you type
	"ray-x/lsp_signature.nvim",
	config = function()
		require("lsp_signature").setup()
	end,
}
