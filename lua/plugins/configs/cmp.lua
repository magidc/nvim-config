return {
	"hrsh7th/nvim-cmp",
	lazy = true,
	dependencies = {
		"hrsh7th/cmp-copilot",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		-- "hrsh7th/cmp-nvim-lsp-document-symbol",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		-- "lukas-reineke/cmp-under-comparator", -- Better sort completion items starting with underscore (Python)
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
			preselect = cmp.PreselectMode.Item,
			-- completion = { autocomplete = false }, -- Make completion only on demand
			enabled = function()
				local in_prompt = vim.api.nvim_buf_get_option(0, "buftype") == "prompt"
				if in_prompt then
					return false
				end
				local context = require("cmp.config.context")
				return not (context.in_treesitter_capture("comment") == true or context.in_syntax_group("Comment"))
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
					symbol_map = { Copilot = "" },
				}),
			},

			mapping = cmp.mapping.preset.insert({
                -- Not interested in going up and down using Tab, there is already C-n/C-p or arrows. Tab is reserved for snippets or Copilot
				["<Tab>"] = cmp.mapping(function(fallback)
					if luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),

				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-q>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({
					select = true,
				}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "luasnip" },
				{ name = "path" },
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
