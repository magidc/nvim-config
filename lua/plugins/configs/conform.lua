return {
	"stevearc/conform.nvim",
	opts = {
		formatters = {
			xmllint = {
				command = "xmllint",
				args = { "--format", "-" },
				-- Send file contents to stdin, read new contents from stdout (default true)
				-- When false, will create a temp file (will appear in "$FILENAME" args). The temp
				-- file is assumed to be modified in-place by the format command.
				stdin = true,
			},
			tidy = {
				command = "tidy",
				args = { "--tidy-mark", "no", "-quiet", "-indent", "-wrap", "0" },
				stdin = true,
			},
		},

		formatters_by_ft = {
			lua = { "stylua" },
			json = { "jq" },
			html = { { "prettierd", "prettier", "tidy" } },
			css = { { "prettierd", "prettier", "tidy" } },
			xhtml = { "xmllint", "tidy" },
			xml = { "xmllint" },
			xsd = { "xmllint" },
			javascript = { { "prettierd", "prettier" } },
		},
	},
}
