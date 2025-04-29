return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
          "bashls",
					"dotls",
          "elixirls",
          "gradle_ls",
          "groovyls",
          "jdtls",
          "jqls",
          "jsonls",
          "kotlin_language_server",
          "matlab_ls",
          "pyright",
					"html",
					"tsp_server",
					"eslint",
					"rust_analyzer",
					"lua_ls",
					"bashls",
					"dockerls",
					"docker_compose_language_service",
					"yamlls",
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"williamboman/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
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
