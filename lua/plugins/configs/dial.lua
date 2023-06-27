return {
	"monaqa/dial.nvim",
	config = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			default = {
				augend.integer.alias.decimal_int,
				augend.integer.alias.decimal,
				augend.integer.alias.hex,
				augend.semver.alias.semver,
				augend.constant.alias.bool,
				augend.date.alias["%d/%m/%y"],
				augend.date.alias["%d/%m/%Y"],
				augend.constant.new({
					elements = { "private", "protected", "public" },
					word = true, -- if false, terms are incremented even if they are contained withing other words
					cyclic = true,
				}),
			},
		})

		vim.api.nvim_set_keymap("n", "<c-a>", require("dial.map").inc_normal(), { noremap = true })
		vim.api.nvim_set_keymap("n", "<c-x>", require("dial.map").dec_normal(), { noremap = true })
		vim.api.nvim_set_keymap("n", "g<c-a>", require("dial.map").inc_gnormal(), { noremap = true })
		vim.api.nvim_set_keymap("n", "g<c-x>", require("dial.map").dec_gnormal(), { noremap = true })
		vim.api.nvim_set_keymap("v", "<c-a>", require("dial.map").inc_visual() .. "gv", { noremap = true })
		vim.api.nvim_set_keymap("v", "<c-x>", require("dial.map").dec_visual() .. "gv", { noremap = true })
		vim.api.nvim_set_keymap("v", "g<c-a>", require("dial.map").inc_gvisual() .. "gv", { noremap = true })
		vim.api.nvim_set_keymap("v", "g<c-x>", require("dial.map").dec_gvisual() .. "gv", { noremap = true })
	end,
}
