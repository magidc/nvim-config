return {
		"chrisgrieser/nvim-various-textobjs",
		config = function()
			require("various-textobjs").setup({
        keymaps = {
          -- See overview table in README for the defaults. (Note that lazy-loading
          -- this plugin, the default keymaps cannot be set up. if you set this to
          -- `true`, you thus need to add `lazy = false` to your lazy.nvim config.)
          useDefaults = true,

          -- disable only some default keymaps, for example { "ai", "!" }
          -- (only relevant when you set `useDefaults = true`)
          ---@type string[]
          disabledDefaults = {},
        },

				-- lines to seek forwards for "small" textobjs (mostly characterwise textobjs)
				-- set to 0 to only look in the current line
        forwardLooking = {
          -- Number of lines to seek forwards for a text object. See the overview
          -- table in the README for which text object uses which value.
          small = 5,
          -- lines to seek forwards for "big" textobjs (mostly linewise textobjs)
          big = 15,
        },
			})
		end,
	}
