local function start_language_server(pattern, callback)
    vim.api.nvim_create_autocmd({"FileType"}, {
        pattern = pattern,
        callback =  callback,
        desc = "Start language server: " .. pattern
    })
end

-- JAVA
local _jdtls, jdtls = pcall(require, "lsp.configs.jdtls")
if _jdtls and type(jdtls) ~= 'boolean' then
    start_language_server('java', jdtls.start)
end

-- RUST
local _rust, rust = pcall(require, "rust-tools")
if _rust then
    local opts = {
        server = {
            standalone = true,
            cmd = { LSP_ROOT_PATH .. "/rust_analyzer/rust-analyzer" };
        },
    }
    rust.setup(opts)
end

-- PYTHON
require 'lspconfig'.pyright.setup {
    cmd = { LSP_ROOT_PATH .. "/pyright/node_modules/.bin/pyright-langserver", "--stdio" };
}

-- LUA
local sumneko_root_path = LSP_ROOT_PATH .. "/sumneko_lua/extension/server/bin"
require 'lspconfig'.sumneko_lua.setup {
    cmd = { sumneko_root_path .. "/lua-language-server", "-E", sumneko_root_path .. "/main.lua" };
}
