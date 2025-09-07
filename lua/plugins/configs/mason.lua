return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"pyright",
					"lemminx",
					"html",
					"tsp_server",
					"eslint",
					"rust_analyzer",
					"lua_ls",
					"bashls",
					"dockerls",
					"docker_compose_language_service",
					"dotls",
					"gradle_ls",
					"jdtls",
					"jsonls",
				},
			})
		end,
	},
	{
		"williamboman/mason-nvim-dap.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"mfussenegger/nvim-dap",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = {
					"codelldb",
					"javatest",
					"javadbg",
				},
			})
		end,
	},
}
