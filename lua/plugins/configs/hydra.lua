-- Returns a callback that moves 'foldlevel' by delta * count, clamped to the deepest fold of the buffer
-- ('foldlevel' starts at 99, so a plain zm needs dozens of presses before any fold closes)
local function fold_level_step(delta)
	return function()
		local deepest = 0
		for lnum = 1, vim.fn.line("$") do
			deepest = math.max(deepest, vim.fn.foldlevel(lnum))
		end
		if deepest > 0 then
			local level = math.min(vim.wo.foldlevel, deepest) + delta * vim.v.count1
			vim.opt_local.foldlevel = math.max(0, math.min(level, deepest))
		end
	end
end

return {
	-- Custom modes to run commands with a common prefix
	"nvimtools/hydra.nvim",
	config = function()
		local hydra = require("hydra")
		hydra({
			name = "Window resize/focus",
			mode = "n",
			body = "<leader>w",
			heads = {
				{ "<left>", "<c-w>>", { desc = "wider" } },
				{ "<right>", "<c-w><", { desc = "narrower" } },
				{ "<up>", "<c-w>+", { desc = "taller" } },
				{ "<down>", "<c-w>-", { desc = "shorter" } },
				{ "h", "<c-w>h", { desc = "left" } },
				{ "j", "<c-w>j", { desc = "down" } },
				{ "k", "<c-w>k", { desc = "up" } },
				{ "l", "<c-w>l", { desc = "right" } },
				{ "=", "<c-w>=", { desc = "equalize" } },
			},
		})

		hydra({
			name = "Fold navigation and management",
			mode = "n",
			body = "<leader>z",
			heads = {
				{ "e", "zo", { desc = "open" } },
				{ "E", fold_level_step(1), { desc = "open level" } },
				{ "c", "zc", { desc = "close" } },
				{ "C", fold_level_step(-1), { desc = "close level" } },
				{ " ", "za", { desc = "toggle" } },
				{ "j", "zj", { desc = "next" } },
				{ "k", "zk", { desc = "previous" } },
			},
		})

		local okdap, dap = pcall(require, "dap")

		if not okdap then
			return
		end

		local hint_dap = [[
 _r_: Run last          _d_: Debug/Resume                   _k_: Terminate
 _b_: Toggle breakpoint _B_: Toggle conditional breakpoint  _l_: Toggle log point breakpoint
 _n_: Step over         _i_: Step into                      _o_: Step out                       _x_: Evaluate
 _p_: Toggle REPL       _u_: Toggle UI
 _q_: exit
]]

		hydra({
			hint = hint_dap,
			config = {
				invoke_on_body = true,
				hint = {
					position = "bottom",
					float_opts = { border = "rounded" },
				},
			},
			name = "DAP",
			mode = { "n", "x" },
			body = "<leader>x",
			heads = {
				{ "r", dap.run_last, { silent = true } },
				{ "d", dap.continue, { silent = true } },
				{ "k", dap.terminate, { silent = true } },
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
	end,
}
