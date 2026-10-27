return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dapui = require("dapui")
		dapui.setup({
			icons = {
				expanded = "▾",
				collapsed = "▸",
			},
			controls = {
				icons = {
					pause = "⏸︎",
					play = "⏵︎",
					step_into = "↓",
					step_over = "⤼",
					step_out = "↑",
					step_back = "←",
					run_last = "↻",
					terminate = "⏹︎",
					disconnect = "⏏︎",
				},
			},
		})
		local dap = require("dap")

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
	end,
}
