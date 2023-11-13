return {
	"williamboman/mason-lspconfig.nvim",
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"jdtls",
				"pyright",
				"lemminx",
				"html",
				"tsserver",
				"eslint",
				"rust_analyzer",
				"lua_ls",
				"bashls",
			},
			automatic_installation = true,
		})
	end,
}
