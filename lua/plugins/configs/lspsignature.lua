local ok, signature = pcall(require, "lsp_signature")

if not ok then
    return
end

signature.setup()

