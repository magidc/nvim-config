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

	-- YAMLs
  lspconfig.yamlls.setup({
  	autostart = false,
  })

  -- CMake Language Server
  lspconfig.cmake.setup({})

  -- Elixir Language Server
  lspconfig.elixirls.setup({
    autostart = false,
    capabilities = capabilities,
  })

  -- Erlang Language Server
  lspconfig.erlangls.setup({
    autostart = false,
    capabilities = capabilities,
  })

  -- Go Language Server
  lspconfig.gopls.setup({
    autostart = false,
    capabilities = capabilities,
  })

  -- Gradle Language Server
  lspconfig.gradle_ls.setup({
    autostart = false,
    capabilities = capabilities,
  })

  -- Groovy Language Server
  lspconfig.groovyls.setup({})

  -- Helm Language Server
  lspconfig.helm_ls.setup({
    autostart = false,
    capabilities = capabilities,
  })
  
  -- Json Language Server
  lspconfig.jsonls.setup({
    autostart = false,
    capabilities = capabilities,
  })

  -- Kotlin LS
  lspconfig.kotlin_language_server.setup({})

  -- Make Language Server
  lspconfig.autotools_ls.setup({
    autostart = false,
    capabilities = capabilities,
  })

  -- Powershell Language Server
  lspconfig.powershell_es.setup({
    autostart = false,
    capabilities = capabilities,
  })

  -- SQL Language Server
  lspconfig.sqlls.setup({
    autostart = false,
    capabilities = capabilities,
  })

  -- Terraform Language Server
  lspconfig.terraformls.setup({})

end
