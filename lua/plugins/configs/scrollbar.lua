return {
	-- Scroll bar
	"petertriho/nvim-scrollbar",
	branch = "refactor/v2", -- v2 replaces v1 on main on 2026-11-16; drop this line then
	config = function()
		require("scrollbar").setup({
			scrollbar = {
				thumb = {
					highlight = { bg = require("theme").colors.red },
				},
			},
		})
	end,
}
