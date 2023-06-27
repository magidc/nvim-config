return {
	-- Custom modes tu run commands with a common prefix
	"anuvyklack/hydra.nvim",
	config = function()
		-- local ok, hydra = pcall(require, "hydra")
		hydra = require("hydra")
		hydra({
			name = "Window resize/focus",
			mode = "n",
			body = "<leader>w",
			heads = {
				{ "<left>", "<c-w>>" },
				{ "<right>", "<c-w><" },
				{ "<up>", "<c-w>+" },
				{ "<down>", "<c-w>-" },
				{ "h", "<c-w>h" },
				{ "j", "<c-w>j" },
				{ "k", "<c-w>k" },
				{ "l", "<c-w>l" },
				{ "=", "<c-w>=" },
			},
		})

		hydra({
			name = "Fold navigation and management",
			mode = "n",
			body = "<leader>z",
			heads = {
				{ "e", "zo" },
				{ "E", "zr" },
				{ "c", "zc" },
				{ "C", "zm" },
				{ " ", "za" },
				{ "j", "zj" },
				{ "k", "zk" },
			},
		})

		local okdap, dap = pcall(require, "dap")

		if not okdap then
			return
		end

		local hint_dap = [[
 _r_: Run               _d_: Debug/Resume                   _k_: Terminate
 _b_: Toggle breakpoint _B_: Toggle conditional breakpoint  _l_: Toggle log point breakpoint
 _n_: Step over         _i_: Step into                      _o_: Step out                       _x_ Evaluate
 _p_: Toggle REPL       _u_: Toggle UI
 _q_: exit
]]

		hydra({
			hint = hint_dap,
			config = {
				color = "pink",
				invoke_on_body = true,
				hint = {
					position = "bottom",
					border = "rounded",
				},
			},
			name = "DAP",
			mode = { "n", "v" },
			body = "<leader>x",
			heads = {
				{ "r", dap.run_last, { silent = true } },
				{ "d", dap.continue, { silent = true } },
				{ "k", dap.close, { silent = true } },
				-- { 'k', dap.disconnect({ terminateDebuggee = false }), { exit = true, silent = true } },
				{ "b", dap.toggle_breakpoint, { silent = true } },
				{
					"B",
					"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
					{ silent = true },
				},
				{
					"l",
					"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
					{ silent = true },
				},
				{ "n", dap.step_over, { silent = true } },
				{ "i", dap.step_into, { silent = true } },
				{ "o", dap.step_out, { silent = true } },
				{ "x", "<cmd>lua require('dapui').eval()<cr>", { silent = true } },
				{ "p", "<cmd>lua require('dap.repl').toggle()<cr>", { silent = true } },
				{ "u", "<cmd>lua require('dapui').toggle()<cr>", { silent = true } },
				{ "q", nil, { exit = true, nowait = true } },
			},
		})
		require("plugins.configs.hydra")
	end,
}
