local M = {}
local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

local function set_document_higlighting(client)
  if client.server_capabilities.documentFormattingProvider then
    require("illuminate").on_attach(client)
  end
end

local function set_signature_helper(client)
  if client.server_capabilities.signatureHelpProvider then
    require("lsp_signature").on_attach({
      bind = true,
      handler_opts = {
        border = "single",
      },
    })
  end
end

local function set_hover_border(client)
  if client.server_capabilities.hoverProvider then
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
  end
end

local function get_basic_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  return capabilities
end

M.capabilities = require("cmp_nvim_lsp").update_capabilities(get_basic_capabilities())

return M
