return {
		"chrisgrieser/nvim-various-textobjs",
		config = function()
			require("various-textobjs").setup({
				-- lines to seek forwards for "small" textobjs (mostly characterwise textobjs)
				-- set to 0 to only look in the current line
				lookForwardSmall = 5,

				-- lines to seek forwards for "big" textobjs (mostly linewise textobjs)
				lookForwardBig = 15,

				-- use suggested keymaps (see README)
				useDefaultKeymaps = true,

				-- disable some default keymaps, e.g. { "ai", "ii" }
				disabledKeymaps = {},
			})
		end,
	}
