return {
	-- Multiple cursors
	"mg979/vim-visual-multi",
	event = "VeryLazy",
	init = function()
		vim.g.VM_leader = "<leader>m" -- "\" is flash's jump key
		vim.g.VM_force_maps = { "[", "]" } -- Map Goto Prev/Next over which-key's buffer-local triggers
		-- On exit VM deletes the buffer maps it replaced instead of restoring them
		vim.api.nvim_create_autocmd("User", {
			group = vim.api.nvim_create_augroup("VisualMultiExit", { clear = true }),
			pattern = "visual_multi_exit",
			callback = function(ev)
				pcall(function() -- which-key.buf is internal: re-attach the buffer's [ ] triggers
					require("which-key.buf").clear({ buf = ev.buf })
					require("which-key.buf").get({ buf = ev.buf })
				end)
				pcall(function() -- Restore nvim-autopairs' insert <BS>
					require("nvim-autopairs").force_attach(ev.buf)
				end)
			end,
		})
	end,
}
