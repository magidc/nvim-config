local ok, aerial = pcall(require, "aerial")

if not ok then
	return
end

aerial.setup({
	log_level = "info",
	backends = { "treesitter", "lsp" },
	highlight_on_hover = true,
     attach_mode = "global",
	filter_kind = {
		"Class",
		"Field",
		"Variable",
		"Constructor",
		"Enum",
		"Function",
		"Interface",
		"Module",
		"Method",
		"Struct",
	},
})
