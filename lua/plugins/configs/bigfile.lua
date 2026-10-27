return {
	"LunarVim/bigfile.nvim",
	config = function()
		require("bigfile").setup({
			filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
			pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
			features = { -- features to disable
				"illuminate",
				"lsp",
				"treesitter", -- sets b:bigfile_disable_treesitter, which treesitter.lua checks
				"syntax",
				"matchparen",
				"vimopts",
				"filetype",
			},
		})
	end,
}

-- To manually set filetype or syntax: :set filetype=html, :set syntax=html
