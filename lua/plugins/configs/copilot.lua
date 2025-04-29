return {
	"github/copilot.vim",
	config = function()

	end,
}

-- Alternative to copilot/cmp plugins
-- return {
-- 	"zbirenbaum/copilot.lua",
-- 	dependencies = { "zbirenbaum/copilot-cmp" },
-- 	cmd = "Copilot",
-- 	event = "InsertEnter",
-- 	config = function()
-- 		require("copilot").setup({
-- 			suggestion = { enabled = false },
-- 			panel = { enabled = false },
-- 		})
-- 		require("copilot_cmp").setup()
-- 	end,
-- }
