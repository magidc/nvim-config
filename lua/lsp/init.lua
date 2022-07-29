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
    rust.setup()
end

-- PYTHON
require 'lspconfig'.pyright.setup {}

-- LUA
local sumneko_root_path = os.getenv("HOME") .. "/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin"
require 'lspconfig'.sumneko_lua.setup {
    cmd = { sumneko_root_path .. "/lua-language-server", "-E", sumneko_root_path .. "/main.lua" };
}
