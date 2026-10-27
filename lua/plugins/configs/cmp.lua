return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" }, -- jsregexp is needed by snippet transformations
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"lukas-reineke/cmp-under-comparator", -- Better sort completion items starting with underscore (Python)
		"onsails/lspkind.nvim", -- VSCode like item type icons
	},
	config = function()
		local _cmp, cmp = pcall(require, "cmp")
		local _luasnip, luasnip = pcall(require, "luasnip")
		local _lspkind, lspkind = pcall(require, "lspkind")

		if not _cmp or not _lspkind or not _luasnip then
			return
		end

		-- Lazy load all vscode like snippets
		require("luasnip/loaders/from_vscode").lazy_load()

		cmp.setup({
			--[[
                No item is preselected by default.
                Unless one item is explicitly selected, Tab button expands or jumps in snippets instead of completing.
                If you want to automatically select the first item in the completion menu:
                    preselect = cmp.PreselectMode.Item,
            ]]
			preselect = cmp.PreselectMode.None,

			-- If uncommented, CMP menu won't open automatically, it would be necessary to press <C-Space> to open it.
			-- completion = { autocomplete = false },
			enabled = function()
				-- Same guards as CMP default: prompt buffers and macro recording/replay
				if vim.bo.buftype == "prompt" or vim.fn.reg_recording() ~= "" or vim.fn.reg_executing() ~= "" then
					return false
				end
				-- The comment check is about buffer text: it must not disable ':' and '/' completion
				if vim.api.nvim_get_mode().mode:sub(1, 1) == "c" then
					return true
				end
				local context = require("cmp.config.context")
				return not (context.in_treesitter_capture("comment") or context.in_syntax_group("Comment"))
			end,
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			sorting = {
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.recently_used,
					cmp.config.compare.score,
					require("cmp-under-comparator").under,
					cmp.config.compare.locality,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol",
					maxwidth = 50,
					ellipsis_char = "...",
					show_labelDetails = true, -- show labelDetails in menu. Disabled by default
				}),
			},

			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping(function(fallback)
					-- Tab accepts the completion if CMP menu is visible and one item is selected
					-- If not it will expand a snippet, jump inside the snippet under the cursor or send a regular Tab
					if cmp.visible() and cmp.get_selected_entry() then
						cmp.confirm({ select = true })
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),

				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-q>"] = cmp.mapping.abort(),
				-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			sources = {
				{ name = "path" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "luasnip" },
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = { { name = "buffer" } },
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
		})
	end,
}
