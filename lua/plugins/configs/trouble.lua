local ok, trouble = pcall(require, "trouble")

if not ok then
    return
end

trouble.setup {
    mode = "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
}
