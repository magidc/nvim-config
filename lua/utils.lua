local _M = {}

_M.set_indent_sizes = function(filetypes)
	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("IndentSizes", { clear = true }),
		pattern = vim.tbl_keys(filetypes),
		callback = function(args)
			local size = filetypes[args.match]
			vim.bo[args.buf].shiftwidth = size
			vim.bo[args.buf].tabstop = size
			vim.bo[args.buf].softtabstop = size
		end,
	})
end

return _M
