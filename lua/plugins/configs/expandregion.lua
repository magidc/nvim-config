return {
	-- Visual +/_ where Neovim's an/in have neither a treesitter parser nor an LSP selection range (see mappings.lua)
	"terryma/vim-expand-region",
	init = function()
		-- Text objects to expand through (1 = also their enclosing levels); il/ie of the defaults need other plugins
		vim.g.expand_region_text_objects =
			{ iw = 0, iW = 0, ['i"'] = 0, ["i'"] = 0, ["i]"] = 1, ib = 1, iB = 1, it = 1, ip = 0 }
		-- The plugin does not map + and _ itself when its <Plug> keys are already mapped
		vim.keymap.set("x", "<Plug>(expand-region-grow)", "<Plug>(expand_region_expand)")
		vim.keymap.set("x", "<Plug>(expand-region-shrink)", "<Plug>(expand_region_shrink)")
	end,
}
