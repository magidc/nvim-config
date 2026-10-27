return {
	"stevearc/conform.nvim",
	cmd = "ConformInfo",
	opts = {
		formatters = {
			tidy = {
				command = "tidy",
				args = {
					"--tidy-mark",
					"no",
					"-quiet",
					"-indent",
					"-wrap",
					"0",
					"--show-body-only",
					"auto",
					"--drop-empty-elements",
					"no",
					"--custom-tags",
					"blocklevel",
					"--show-warnings",
					"no",
				},
				stdin = true,
				exit_codes = { 0, 1 }, -- 1 = warnings only; 2 = errors (no output) still fails
			},
			beautysh = {
				prepend_args = function(_, ctx)
					return { "--indent-size", tostring(ctx.shiftwidth) }
				end,
			},
		},

		formatters_by_ft = {
			lua = { "stylua" },
			sh = { "beautysh" },
			zsh = { "beautysh" },
			json = { "jq" },
			html = { "prettierd", "prettier", "tidy", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			xhtml = { "xmllint", "tidy", stop_after_first = true },
			xml = { "xmllint" },
			xsd = { "xmllint" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			python = { "ruff_organize_imports", "ruff_format" },
			rust = { "rustfmt", lsp_format = "fallback" },
		},
	},
}
