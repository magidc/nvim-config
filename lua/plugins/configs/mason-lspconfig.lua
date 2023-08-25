return {
	"williamboman/mason-lspconfig.nvim",
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = { "codelldb", "jdtls" },
			automatic_installation = true,
		})
	end,
}
