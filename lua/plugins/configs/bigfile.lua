return {
	"LunarVim/bigfile.nvim",
	config = function()
		require("bigfile").setup({
			filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
			pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
			features = { -- features to disable
				"indent_blankline",
				"illuminate",
				"lsp",
				"treesitter",
				"syntax",
				"matchparen",
				"vimopts",
				-- "filetype",
			},
		})
	end,
}

-- To manually set filetype or syntax: :set filetype=html, :set syntax=html
