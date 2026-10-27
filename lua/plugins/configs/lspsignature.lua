return {
	-- Show function signature when you type
	"ray-x/lsp_signature.nvim",
	-- Not on LspAttach: setup() attaches the running clients and lazy would replay that event (attaching twice)
	event = "InsertEnter",
	config = function()
		require("lsp_signature").setup({
			bind = true, -- This is mandatory, otherwise border config won't get registered.
			doc_lines = 2, -- will show two lines of comment/doc (longer docs are truncated)
			floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
			hint_enable = false, -- virtual hint enable
			hi_parameter = "Search", -- how your parameter will be highlight
			max_height = 12, -- max height of signature floating_window
			max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
			handler_opts = {
				border = "single", -- double, single, shadow, none
			},
		})
	end,
}
