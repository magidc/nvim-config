-- Sort items starting with underscores (Python's _private and __dunder__) after the rest
local function underscores_last(a, b)
	local _, a_under = a.label:find("^_+")
	local _, b_under = b.label:find("^_+")
	a_under, b_under = a_under or 0, b_under or 0
	if a_under ~= b_under then
		return a_under < b_under
	end
end

-- Completion is disabled inside comments
local function in_comment()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local ok, captures = pcall(vim.treesitter.get_captures_at_pos, 0, row - 1, math.max(col - 1, 0))
	for _, capture in ipairs(ok and captures or {}) do
		if capture.capture:find("^comment") then
			return true
		end
	end
	-- Buffers without a treesitter parser use the regex syntax groups
	for _, id in ipairs(vim.fn.synstack(row, math.max(col, 1))) do
		if vim.fn.synIDattr(vim.fn.synIDtrans(id), "name") == "Comment" then
			return true
		end
	end
	return false
end

return {
	"saghen/blink.cmp",
	version = "1.*", -- Release tags download the prebuilt Rust fuzzy matcher
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp", -- jsregexp is needed by snippet transformations
			dependencies = { "rafamadriz/friendly-snippets" },
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- Blink's own guards (macros, prompt buffers, vim.b.completion) still apply
		enabled = function()
			return not in_comment()
		end,
		keymap = {
			preset = "none",
			-- Tab accepts the completion only if one item is explicitly selected,
			-- otherwise it jumps inside the snippet under the cursor or sends a regular Tab
			["<Tab>"] = {
				function(cmp)
					if cmp.get_selected_item() then
						return cmp.accept()
					end
				end,
				"snippet_forward",
				"fallback",
			},
			["<S-Tab>"] = { "snippet_backward", "fallback" },
			-- Accepts the selected item or, if none is selected, the first one
			["<CR>"] = { "select_and_accept", "fallback" },
			["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-q>"] = { "cancel", "fallback" },
			["<C-n>"] = { "select_next", "fallback_to_mappings" },
			["<C-p>"] = { "select_prev", "fallback_to_mappings" },
			["<Down>"] = { "select_next", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
		},
		-- Function signature while typing the arguments
		signature = { enabled = true, window = { border = "rounded" } },
		appearance = {
			nerd_font_variant = "normal", -- install_nvim.sh installs FiraCode Nerd Font (not Mono)
		},
		completion = {
			list = { selection = { preselect = false, auto_insert = true } },
			menu = { border = "rounded" },
			documentation = { auto_show = true, window = { border = "rounded" } },
		},
		snippets = { preset = "luasnip" },
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		fuzzy = {
			implementation = "prefer_rust_with_warning",
			sorts = { "exact", "score", underscores_last, "sort_text" },
		},
		cmdline = {
			completion = { menu = { auto_show = true } },
		},
	},
	opts_extend = { "sources.default" },
}
