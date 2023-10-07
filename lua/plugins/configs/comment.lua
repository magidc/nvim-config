return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup({
			toggler = {
				---Line-comment toggle keymap
				line = "<c-_>", -- It traslates to Ctrl /
			},
		})
	end,
}
