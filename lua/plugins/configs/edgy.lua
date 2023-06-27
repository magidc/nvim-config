return {
	-- Create and manage predefined window layouts
	"folke/edgy.nvim",
	event = "VeryLazy",
	config = function()
		require("edgy").setup({
			animate = {
				enabled = true,
				fps = 100, -- frames per second
				cps = 120, -- cells per second
				on_begin = function()
					vim.g.minianimate_disable = true
				end,
				on_end = function()
					vim.g.minianimate_disable = false
				end,
				-- Spinner for pinned views that are loading.
				-- if you have noice.nvim installed, you can use any spinner from it, like:
				-- spinner = require("noice.util.spinners").spinners.circleFull,
				spinner = {
					frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
					interval = 80,
				},
			},
			bottom = {
				-- toggleterm / lazyterm at the bottom with a height of 40% of the screen
				{
					ft = "toggleterm",
					size = { height = 0.4 },
					-- exclude floating windows
					filter = function(buf, win)
						return vim.api.nvim_win_get_config(win).relative == ""
					end,
				},
				"Trouble",
				{ ft = "qf", title = "QuickFix" },
				{
					ft = "help",
					size = { height = 20 },
					-- only show help buffers
					filter = function(buf)
						return vim.bo[buf].buftype == "help"
					end,
				},
				{ ft = "spectre_panel", size = { height = 0.4 } },
			},
			left = {
				-- Neo-tree filesystem always takes half the screen height
				{
					title = "Neo-Tree",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "filesystem"
					end,
					size = { height = 0.5 },
				},
				{
					title = "Neo-Tree Git",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "git_status"
					end,
					pinned = true,
					open = "Neotree position=right git_status",
				},
				{
					title = "Neo-Tree Buffers",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "buffers"
					end,
					pinned = true,
					open = "Neotree position=top buffers",
				},
				-- any other neo-tree windows
				"neo-tree",
			},
		})
	end,
}
