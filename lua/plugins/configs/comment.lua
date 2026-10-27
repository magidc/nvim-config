return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup({
			-- toggler = {
			-- 	-- line = "<c-_>", -- It traslates to Ctrl /
			-- },
			-- Buffers without a treesitter parser (pom.xml, Makefile, *.properties...): Comment.nvim's treesitter
			-- lookup expects get_parser() to throw, but on Neovim 0.12 it returns nil, so give it the commentstring
			pre_hook = function(ctx)
				local ok, parser = pcall(vim.treesitter.get_parser, 0)
				if not ok or not parser then
					return require("Comment.ft").get(vim.bo.filetype, ctx.ctype) or vim.bo.commentstring
				end
			end,
		})
		---Line-comment toggle keymap
		-- I prefer to set this mapping in this way instead in 'toggler' section from setup configuration cause here I can jump to next line after commenting a line
		-- In tmux
		vim.api.nvim_set_keymap("n", "<c-_>", "gccj", { silent = true, expr = false })
		vim.api.nvim_set_keymap("x", "<c-_>", "gc", { silent = true, expr = false })
		-- Out of tmux
		vim.api.nvim_set_keymap("n", "<c-/>", "gccj", { silent = true, expr = false })
		vim.api.nvim_set_keymap("x", "<c-/>", "gc", { silent = true, expr = false })
	end,
}
