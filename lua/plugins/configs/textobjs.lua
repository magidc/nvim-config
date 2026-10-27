return {
	"chrisgrieser/nvim-various-textobjs",
	config = function()
		require("various-textobjs").setup({
			forwardLooking = {
				-- lines to seek forwards for "small" textobjs (mostly characterwise textobjs)
				-- set to 0 to only look in the current line
				small = 5,
				-- lines to seek forwards for "big" textobjs (mostly linewise textobjs)
				big = 15,
			},
			keymaps = {
				-- use suggested keymaps (see README)
				useDefaults = true,
				-- disable some default keymaps, e.g. { "ai", "ii" }
				-- These ones shadow built-ins (Visual an/in treesitter selection, r, R, !, gw, |, n),
				-- the treesitter am/im method textobjects or the L/C maps from mappings.lua
				disabledDefaults = { "am", "im", "an", "in", "r", "R", "!", "gw", "|", "n", "L", "C" },
			},
		})
	end,
}
