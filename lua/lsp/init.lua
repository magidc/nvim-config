local capabilities = require("lsp.handlers").capabilities

local _lspconfig, lspconfig = pcall(require, "lspconfig")
if _lspconfig then
	-- Python
	lspconfig.pyright.setup({
    autostart = false,
  })

	-- LUA
	lspconfig.lua_ls.setup({
		autostart = false,
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
	-- Clangd (C++)
	lspconfig.clangd.setup({})

	-- Bash
	lspconfig.bashls.setup({
		autostart = false,
	})

	-- Javascript/Typescript
	lspconfig.eslint.setup({
		autostart = true,
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
	lspconfig.html.setup({
		autostart = false,
		capabilities = capabilities,
	})

	-- CSS
	lspconfig.cssls.setup({
		autostart = false,
		capabilities = capabilities,
	})

	-- Dockerfile
	lspconfig.dockerls.setup({
		autostart = false,
		capabilities = capabilities,
	})

	-- Docker compose
	lspconfig.docker_compose_language_service.setup({
		autostart = false,
		capabilities = capabilities,
	})
	-- XML
	lspconfig.lemminx.setup({})

	-- VUE
	lspconfig.vuels.setup({})
end
