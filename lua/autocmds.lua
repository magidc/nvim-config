local api = vim.api

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.hl.on_yank()
	end,
	group = highlight_group,
})

-- go to last loc when opening a buffer (except commit messages, rebase todos, xxd and diff, see :h restore-cursor)
api.nvim_create_autocmd("BufReadPost", {
	group = api.nvim_create_augroup("RestoreCursor", { clear = true }),
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		if vim.wo.diff or ft:find("commit", 1, true) or ft == "gitrebase" or ft == "xxd" then
			return
		end
		local mark = api.nvim_buf_get_mark(args.buf, '"')
		local lcount = api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Disable automatic line breaks
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("NoAutoWrap", { clear = true }),
	pattern = "*",
	callback = function()
		vim.opt_local.textwidth = 0
		vim.opt_local.formatoptions:remove({ "t", "c", "a", "r", "o" })
	end,
})
