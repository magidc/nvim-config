return {
	-- Rust-tools
	{
		"simrat39/rust-tools.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
			"mfussenegger/nvim-dap",
		},
		enabled = true,
		ft = { "rust", "toml" },
		config = function()
			local handlers = require("lsp.handlers")
			local extension_path = require("mason-registry").get_package("codelldb"):get_install_path() .. "/extension/"
			local codelldb_path = extension_path .. "adapter/codelldb"
			local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
			local rust_tools = require("rust-tools")

			rust_tools.setup({
				tools = {
					executor = require("rust-tools.executors").termopen,
					autoSetHints = true,
					runnables = {
						use_telescope = true,
					},
					reload_workspace_from_cargo_toml = true,
					on_initialized = function()
						vim.cmd([[
                  augroup RustLSP
                    autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                    autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                  augroup END
                ]])
					end,
					inlay_hints = {
						auto = false,
						only_current_line = false,
						show_parameter_hints = true,
						parameter_hints_prefix = "<- ",
						other_hints_prefix = "=> ",
						max_len_align = false,
						max_len_align_padding = 1,
						right_align = false,
						right_align_padding = 7,
						highlight = "Comment",
					},
					hover_actions = {
						border = {
							{ "╭", "FloatBorder" },
							{ "─", "FloatBorder" },
							{ "╮", "FloatBorder" },
							{ "│", "FloatBorder" },
							{ "╯", "FloatBorder" },
							{ "─", "FloatBorder" },
							{ "╰", "FloatBorder" },
							{ "│", "FloatBorder" },
						},
						max_width = nil,
						max_height = nil,
						auto_focus = true,
					},
					crate_graph = {
						backend = "x11",
						output = nil,
						full = true,
						enabled_graphviz_backends = {
							"bmp",
							"cgimage",
							"canon",
							"dot",
							"gv",
							"xdot",
							"xdot1.2",
							"xdot1.4",
							"eps",
							"exr",
							"fig",
							"gd",
							"gd2",
							"gif",
							"gtk",
							"ico",
							"cmap",
							"ismap",
							"imap",
							"cmapx",
							"imap_np",
							"cmapx_np",
							"jpg",
							"jpeg",
							"jpe",
							"jp2",
							"json",
							"json0",
							"dot_json",
							"xdot_json",
							"pdf",
							"pic",
							"pct",
							"pict",
							"plain",
							"plain-ext",
							"png",
							"pov",
							"ps",
							"ps2",
							"psd",
							"sgi",
							"svg",
							"svgz",
							"tga",
							"tiff",
							"tif",
							"tk",
							"vml",
							"vmlz",
							"wbmp",
							"webp",
							"xlib",
							"x11",
						},
					},
				},
				server = {
					on_attach = function(_, bufnr)
						handlers.on_attach(_, bufnr)
						wk = require("which-key")
						wk.add({
							{ "<leader>dE", "<cmd>RustDebuggables<cr>", desc = "[RUST] Show debug configurations" },
							{ "<leader>de", "<cmd>RustLastDebug<cr>", desc = "[RUST] Debug last" },
							{ "<leader>dR", "<cmd>RustRun<cr>", desc = "[RUST] Show run configurations" },
							{ "<leader>dr", "<cmd>RustLastRun<cr>", desc = "[RUST] Run last" },
						})
					end,
					capabilities = handlers.capabilities,
					standalone = false,
				},
				dap = {
					adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
				},
			})
		end,
	},
	-- Crates
	{
		"saecki/crates.nvim",
		enabled = true,
		event = { "BufRead Cargo.toml" },
		tag = "v0.4.0",
		lazy = true,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup({
				src = {
					--[[ 	coq = {
						enabled = true,
						name = "crates.nvim",
					}, ]]
					cmp = {
						enabled = true,
					},
				},
				popup = {
					border = "rounded",
				},
			})
		end,
	},
}
