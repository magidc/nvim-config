local capabilities = require("lsp.handlers").capabilities

-- local _lspconfig, lspconfig = pcall(require, "lspconfig")
local lspconfig = vim.lsp.config

if lspconfig then
	-- Python
	lspconfig("pyright", {
		capabilities = capabilities,
		filetypes = { "python" },
	})

	-- LUA
	lspconfig("lua_ls", {
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	})
	-- Rust
	lspconfig("rust_analyzer", {
		on_attach = function(client, bufnr)
			require("lsp.handlers").on_attach(client, bufnr)
			-- vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end,
		-- capabilities = capabilities,
		settings = {
			["rust-analyzer"] = {
				diagnostics = {
					enable = true,
				},
				imports = {
					granularity = {
						group = "module",
					},
					prefix = "self",
				},
				cargo = {
					buildScripts = {
						enable = true,
					},
				},
				procMacro = {
					enable = true,
				},
			},
		},
	})

	-- Clangd (C++)
	lspconfig("clangd", {
		capabilities = capabilities,
	})

	-- Bash
	lspconfig("bashls", {
		capabilities = capabilities,
	})

	-- Javascript/Typescript
	lspconfig("eslint", {
		capabilities = capabilities,
		settings = {
			packageManager = "npm",
		},
		on_attach = function(client, bufnr)
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				command = "EslintFixAll",
			})
		end,
	})

	-- HTML
	lspconfig("html", {
		capabilities = capabilities,
	})

	-- CSS
	lspconfig("cssls", {
		capabilities = capabilities,
	})

	-- Dockerfile
	lspconfig("dockerls", {
		capabilities = capabilities,
	})

	-- Docker compose
	lspconfig("docker_compose_language_service", {
		capabilities = capabilities,
	})
	-- XML
	lspconfig("lemminx", {
		capabilities = capabilities,
	})

	-- VUE
	lspconfig("vuels", {
		capabilities = capabilities,
	})

	-- YAMLs
	lspconfig("yamlls", {
		capabilities = capabilities,
	})

	-- CMake Language Server
	lspconfig("cmake", {
		capabilities = capabilities,
	})

	-- Elixir Language Server
	lspconfig("elixirls", {
		capabilities = capabilities,
	})

	-- -- Go Language Server
	-- lspconfig("gopls",{
	-- 	capabilities = capabilities,
	-- })

	-- Gradle Language Server
	lspconfig("gradle_ls", {
		capabilities = capabilities,
	})

	-- -- Groovy Language Server
	-- lspconfig("groovyls",{
	-- 	capabilities = capabilities,
	-- })

	-- Json Language Server
	lspconfig("jsonls", {
		capabilities = capabilities,
	})

	-- Kotlin LS
	lspconfig("kotlin_language_server", {
		capabilities = capabilities,
	})

	-- Make Language Server
	lspconfig("autotools_ls", {
		capabilities = capabilities,
	})

	-- Powershell Language Server
	lspconfig("powershell_es", {
		capabilities = capabilities,
	})

	-- SQL Language Server
	lspconfig("sqlls", {
		capabilities = capabilities,
	})

	-- Terraform Language Server
	lspconfig("terraformls", {
		capabilities = capabilities,
	})
end
