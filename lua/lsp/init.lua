-- Servers are started by hand (:lsp enable <name>) with nvim-lspconfig's configurations; only what differs from
-- them is configured here. Mason installs the servers listed in plugins/configs/mason.lua
local lspconfig = vim.lsp.config

lspconfig("*", {
	capabilities = require("lsp.handlers").capabilities,
})

-- Diagnostic messages at the end of their lines (Nvim only shows signs by default); a line with several diagnostics
-- shows the sign and the message of the most severe one
vim.diagnostic.config({ virtual_text = true, severity_sort = true })

-- Code lenses of the servers that provide them (grx runs the one under the cursor)
vim.lsp.codelens.enable(true)

-- Client command of the reference and implementation lenses of rust-analyzer and lua_ls, whose arguments are the
-- document, the position and the locations: they go to the quickfix list
local function show_locations(command, ctx)
	local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
	local items = vim.lsp.util.locations_to_items(command.arguments[3] or {}, client.offset_encoding)
	if not next(items) then
		vim.notify("No locations found", vim.log.levels.INFO)
		return
	end
	vim.fn.setqflist({}, " ", { title = command.title, items = items })
	vim.cmd("botright copen")
end

-- Nvim refuses to apply edits whose annotationId has no change annotation: pyright sends its renames that way and
-- lspsaga applies edits without their change annotations. Such edits are applied as plain text edits
local apply_text_edits = vim.lsp.util.apply_text_edits
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.util.apply_text_edits = function(text_edits, bufnr, position_encoding, change_annotations)
	local function annotation_missing(edit)
		return edit.annotationId and not (change_annotations and change_annotations[edit.annotationId])
	end
	if vim.iter(text_edits or {}):any(annotation_missing) then
		text_edits = vim.tbl_map(function(edit)
			return annotation_missing(edit) and { range = edit.range, newText = edit.newText } or edit
		end, text_edits)
	end
	return apply_text_edits(text_edits, bufnr, position_encoding, change_annotations)
end

-- LUA
lspconfig("lua_ls", {
	-- Reference lenses carry their locations (lua.showReferences) instead of only counting them
	init_options = { codeLensViewReferences = true },
	commands = { ["lua.showReferences"] = show_locations },
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
				checkThirdParty = false,
				-- Make the server aware of Neovim runtime files
				library = { vim.env.VIMRUNTIME },
			},
		},
	},
})

-- Rust
-- Command of the Debug lens: cargo builds the runnable, then nvim-dap debugs the executable with codelldb
local function debug_runnable(command)
	local runnable = command.arguments[1]
	local args = runnable.args
	local test = args.cargoArgs[1] ~= "run"
	local cargo = vim.list_extend({ "cargo" }, args.cargoArgs)
	if test then
		table.insert(cargo, "--no-run")
	else
		cargo[2] = "build"
	end
	table.insert(cargo, "--message-format=json-render-diagnostics")
	vim.notify(table.concat(cargo, " "))
	vim.system(
		cargo,
		{ cwd = args.cwd, env = args.environment, text = true },
		vim.schedule_wrap(function(result)
			local executables = {}
			for line in vim.gsplit(result.stdout, "\n", { trimempty = true }) do
				local ok, message = pcall(vim.json.decode, line)
				if
					ok
					and message.reason == "compiler-artifact"
					and type(message.executable) == "string"
					and message.profile.test == test
					and not vim.list_contains(message.target.kind, "custom-build")
				then
					table.insert(executables, message.executable)
				end
			end
			if result.code ~= 0 or #executables ~= 1 then
				local reason = result.code ~= 0 and result.stderr or (#executables .. " executables built")
				vim.notify("Cannot debug " .. runnable.label .. ": " .. reason, vim.log.levels.ERROR)
				return
			end
			require("dap").run({
				type = "codelldb",
				request = "launch",
				name = runnable.label,
				program = executables[1],
				args = args.executableArgs,
				cwd = args.cwd,
				env = args.environment,
				sourceLanguages = { "rust" },
			})
		end)
	)
end

lspconfig("rust_analyzer", {
	-- nvim-lspconfig only provides the command of the Run lens
	commands = {
		["rust-analyzer.showReferences"] = show_locations,
		["rust-analyzer.debugSingle"] = debug_runnable,
	},
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
		},
	},
})

-- Javascript/Typescript
local eslint_on_attach = vim.tbl_get(lspconfig, "eslint", "on_attach") -- nvim-lspconfig's, it defines :LspEslintFixAll
local eslint_fix_group = vim.api.nvim_create_augroup("EslintFixAll", { clear = true })
lspconfig("eslint", {
	settings = {
		packageManager = "npm",
	},
	on_attach = function(client, bufnr)
		if not eslint_on_attach then
			return
		end
		eslint_on_attach(client, bufnr)
		vim.api.nvim_clear_autocmds({ group = eslint_fix_group, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = eslint_fix_group,
			buffer = bufnr,
			command = "LspEslintFixAll",
		})
	end,
})

-- ts_ls also handles the TypeScript of .vue files through the Vue plugin of the vue-language-server package:
-- start vue_ls together with it (:lsp enable vue_ls ts_ls)
lspconfig("ts_ls", {
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server"),
				languages = { "vue" },
				configNamespace = "typescript",
			},
		},
	},
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
})

-- HTML
lspconfig("html", {
	-- Without a css section the validation of documents with CSS fails and they get no diagnostics
	settings = {
		css = { validate = true },
	},
})

-- Docker compose: docker_compose_language_service only attaches to the yaml.docker-compose filetype. Besides the
-- default files, the override and per-environment ones (docker-compose.override.yml, compose.prod.yaml,
-- docker-compose-dev.yml...)
vim.filetype.add({
	pattern = {
		["docker%-compose%.ya?ml"] = "yaml.docker-compose",
		["compose%.ya?ml"] = "yaml.docker-compose",
		["docker%-compose[%.%-_][%w%.%-_]+%.ya?ml"] = "yaml.docker-compose",
		["compose[%.%-_][%w%.%-_]+%.ya?ml"] = "yaml.docker-compose",
	},
})
