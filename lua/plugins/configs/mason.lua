-- Python of the project (active virtualenv or conda environment, else python3), not the one of the debugpy package
local function python_path()
	local venv = vim.env.VIRTUAL_ENV or vim.env.CONDA_PREFIX
	return venv and vim.fs.joinpath(venv, "bin", "python") or vim.fn.exepath("python3")
end

-- ensure_installed lists live in opts so that install_nvim.sh can read them
return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			automatic_enable = false,
			ensure_installed = {
				"pyright",
				-- "lemminx",
				"html",
				"ts_ls",
				"eslint",
				"rust_analyzer",
				"lua_ls",
				"bashls",
				"dockerls",
				"docker_compose_language_service",
				"dotls",
				-- Later releases cannot run over stdio (no Main-Class, they need a socket argument)
				"gradle_ls@3.15.0",
				"jdtls",
				"jsonls",
				"clangd",
				"cssls",
				"yamlls",
				"autotools_ls",
				"terraformls",
				"vue_ls",
			},
		},
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = { "mason-org/mason.nvim", "mfussenegger/nvim-dap" },
		opts = {
			ensure_installed = {
				"codelldb",
				"javatest",
				"javadbg",
				"python",
			},
			-- Registers the adapters and configurations of the installed debuggers (codelldb: c/cpp/rust, python)
			handlers = {
				python = function(config)
					-- Debug with the python of the project: mason-nvim-dap's configuration evaluates it at launch,
					-- other configurations (.vscode/launch.json) get it from the adapter unless they set their own
					for _, configuration in ipairs(config.configurations) do
						configuration.pythonPath = python_path
					end
					config.adapters = vim.tbl_extend("force", config.adapters, {
						enrich_config = function(configuration, on_config)
							if not configuration.python and not configuration.pythonPath then
								configuration = vim.tbl_extend("force", configuration, { pythonPath = python_path() })
							end
							on_config(configuration)
						end,
					})
					require("mason-nvim-dap").default_setup(config)
					-- launch.json configurations written by VS Code use the type "debugpy"
					require("dap").adapters.debugpy = config.adapters
				end,
			},
		},
	},
}
