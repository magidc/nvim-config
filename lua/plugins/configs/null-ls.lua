local ok, null_ls = pcall(require, "null-ls")

if not ok then
    return
end
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.xmllint,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.jsonlint,
    },
})
