local ok, lens = pcall(require, "lsp-lens")

if not ok then
    return
end
lens.setup{}
