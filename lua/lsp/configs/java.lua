return {
	"mfussenegger/nvim-jdtls",
	ft = { "java" },
	dependencies = { "mfussenegger/nvim-dap" },
	config = function()
		local jdtls = require("jdtls")
		local handlers = require("lsp.handlers")

		-- Set proper Java executable
		local java_cmd = "java"
		local mason_share = vim.fs.joinpath(vim.env.MASON, "share")
		local jdtls_path = vim.fs.joinpath(mason_share, "jdtls")

		-- java-debug and vscode-java-test bundles
		local bundles = { vim.fs.joinpath(mason_share, "java-debug-adapter", "com.microsoft.java.debug.plugin.jar") }
		local excluded = {
			["com.microsoft.java.test.plugin.jar"] = true, -- link to com.microsoft.java.test.plugin-<version>.jar
			["com.microsoft.java.test.runner-jar-with-dependencies.jar"] = true, -- not an OSGi bundle
			["jacocoagent.jar"] = true, -- not an OSGi bundle
		}
		-- Bundles that jdtls already ships (e.g. org.objectweb.asm) cannot be installed a second time
		local jdtls_bundles = {}
		for _, jar in ipairs(vim.fn.glob(vim.fs.joinpath(jdtls_path, "plugins", "*.jar"), true, true)) do
			local name = vim.fs.basename(jar):match("^(.-)_%d")
			if name then
				jdtls_bundles[name] = true
			end
		end
		for _, jar in ipairs(vim.fn.glob(vim.fs.joinpath(mason_share, "java-test", "*.jar"), true, true)) do
			local fname = vim.fs.basename(jar)
			if not excluded[fname] and not jdtls_bundles[fname:match("^(.-)_%d") or ""] then
				table.insert(bundles, jar)
			end
		end

		-- Must run before the first attach: nvim-jdtls' LspAttach handler calls setup_dap({}),
		-- and setup_dap() does nothing once dap.adapters.java exists
		jdtls.setup_dap({ hotcodereplace = "auto" })
		-- nvim-jdtls' config provider finds the main classes each time DapContinue/DapNew starts a session
		-- (at attach time jdtls cannot resolve them all yet). Its configurations get these overrides
		local dap = require("dap")
		local get_main_class_configs = dap.providers.configs.jdtls
		if get_main_class_configs then
			dap.providers.configs.jdtls = function(bufnr)
				return vim.tbl_map(function(config)
					return vim.tbl_extend("force", config, { vmArgs = "-Dspring.profiles.active=local" })
				end, get_main_class_configs(bufnr))
			end
		end

		local function on_attach(_, bufnr)
			require("which-key").add({
				buffer = bufnr,
				{ "<leader>de", "<cmd>DapContinue<cr>", desc = "[JDTLS] Show debug configurations" },
				{ "<leader>ro", "<cmd>lua require'jdtls'.organize_imports()<cr>", desc = "[JDTLS] Organize imports" },
				{
					"<leader>cs",
					"<cmd>lua require'jdtls'.super_implementation()<cr>",
					desc = "[JDTLS] Go to super implementation",
				},
			})
		end

		local function start(bufnr)
			local root_dir = vim.fs.root(bufnr, {
				{ "mvnw", "gradlew", "settings.gradle", "settings.gradle.kts", ".metadata", ".git" },
				{ "pom.xml", "build.gradle", "build.gradle.kts" },
			}) or vim.fn.getcwd()
			-- One Eclipse workspace per root; the hash keeps apart projects with the same directory name
			local workspace_name = vim.fs.basename(root_dir) .. "-" .. vim.fn.sha256(root_dir):sub(1, 8)
			local workspace_dir = vim.fs.joinpath(vim.env.HOME, ".local", "share", "eclipse", workspace_name)

			-- start_or_attach() modifies the config table, so every buffer gets a new one
			jdtls.start_or_attach({
				cmd = {
					java_cmd,
					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					-- Keep .project, .classpath and .settings out of the project root
					"-Djava.import.generatesMetadataFilesAtProjectRoot=false",
					"-Dlog.protocol=true",
					"-Dlog.level=ALL",
					"-Xms512m",
					"-Xmx2048m",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",
					"-jar",
					vim.fs.joinpath(jdtls_path, "plugins", "org.eclipse.equinox.launcher.jar"),
					"-configuration",
					vim.fs.joinpath(jdtls_path, "config"),
					"-data",
					workspace_dir,
				},
				root_dir = root_dir,
				init_options = {
					bundles = bundles,
				},
				capabilities = handlers.capabilities,
				on_attach = on_attach,
				settings = {
					java = {
						signatureHelp = {
							enabled = true,
						},
						saveActions = {
							organizeImports = true,
						},
						completion = {
							maxResults = 20,
							favoriteStaticMembers = {
								"org.hamcrest.MatcherAssert.assertThat",
								"org.hamcrest.Matchers.*",
								"org.hamcrest.CoreMatchers.*",
								"org.junit.jupiter.api.Assertions.*",
								"java.util.Objects.requireNonNull",
								"java.util.Objects.requireNonNullElse",
								"org.mockito.Mockito.*",
							},
						},
						sources = {
							organizeImports = {
								starThreshold = 9999,
								staticStarThreshold = 9999,
							},
						},
						codeGeneration = {
							toString = {
								template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
							},
						},
					},
				},
			}, nil, { bufnr = bufnr })
		end

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("jdtls_start", { clear = true }),
			pattern = "java",
			callback = function(args)
				-- Only buffers that represent a file, as vim.lsp.enable() does
				if vim.bo[args.buf].buftype == "" then
					start(args.buf)
				end
			end,
		})
	end,
}
