local M = {}

-- Full LSP client capabilities (completion, snippets, signature help) come from blink.cmp
local ok, blink = pcall(require, "blink.cmp")
M.capabilities = ok and blink.get_lsp_capabilities(nil, true) or vim.lsp.protocol.make_client_capabilities()
-- M.capabilities = require("cmp_nvim_lsp").default_capabilities()
-- M.capabilities = require('coq').lsp_ensure_capabilities()

return M
