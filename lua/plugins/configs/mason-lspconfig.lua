return {
	"williamboman/mason-lspconfig.nvim",
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = {  "jdtls" },
			automatic_installation = true,
		})
	end,
}
