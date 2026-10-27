return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "nvim-mini/mini.bufremove" },
	config = function()
		local bufferline = require("bufferline")
		-- Using nvim-mini/mini.bufremove to prevent messy behaviours with other plugins.
		-- With force = false it asks before closing a modified buffer
		local function close_buffer(bufnr)
			require("mini.bufremove").delete(bufnr, false)
		end
		bufferline.setup({
			options = {
				style_preset = bufferline.style_preset.no_italic,
				close_command = close_buffer,
				right_mouse_command = close_buffer,
				indicator = { style = "none" },
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					return "(" .. count .. ")"
				end,
				sort_by = "insert_after_current",
				offsets = {
					{
						filetype = "neo-tree",
						text = function()
							return vim.fn.getcwd()
						end,
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		})
	end,
}
