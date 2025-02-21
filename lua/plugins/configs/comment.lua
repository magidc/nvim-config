return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup({
			-- toggler = {
			-- 	-- line = "<c-_>", -- It traslates to Ctrl /
			-- },
		})
		---Line-comment toggle keymap
		-- I prefer to set this mapping in this way instead in 'toggler' section from setup configuration cause here I can jump to next line after commenting a line
        -- In tmux
		vim.api.nvim_set_keymap("n", "<c-_>", "gccj", { silent = true, expr = false })
        vim.api.nvim_set_keymap("v", "<c-_>", "gc", { silent = true, expr = false })
        -- Out of tmux
		vim.api.nvim_set_keymap("n", "<c-/>", "gccj", { silent = true, expr = false })
        vim.api.nvim_set_keymap("v", "<c-/>", "gc", { silent = true, expr = false })
	end,
}
