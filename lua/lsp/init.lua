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

local _lspconfig, lspconfig = pcall(require, "lspconfig")
if _lspconfig then
    -- PYTHON
    lspconfig.pyright.setup {
        cmd = { LSP_ROOT_PATH .. "/pyright/node_modules/.bin/pyright-langserver", "--stdio" };
    }

    -- LUA
    local sumneko_root_path = LSP_ROOT_PATH .. "/sumneko_lua/extension/server/bin"
    lspconfig.sumneko_lua.setup {
        cmd = { sumneko_root_path .. "/lua-language-server", "-E", sumneko_root_path .. "/main.lua" };
    }

    -- BASH
    local bashls_root_path = LSP_ROOT_PATH .. "/bashls/node_modules/.bin"
    lspconfig.bashls.setup {
        cmd = { bashls_root_path .. "/bash-language-server" };
    }

    -- HTML
    local html_root_path = LSP_ROOT_PATH .. "/html/node_modules/.bin"
    lspconfig.html.setup {
        cmd = { html_root_path .. "/vscode-html-language-server", "--stdio"};
    }

    -- JSON
    lspconfig.jsonls.setup {
        cmd = { html_root_path .. "/vscode-json-language-server", "--stdio"};
    }

    -- CSS
    lspconfig.cssls.setup {
        cmd = { html_root_path .. "/vscode-css-language-server", "--stdio"};
    }

    -- Markdown
    lspconfig.cssls.setup {
        cmd = { html_root_path .. "/vscode-markdown-language-server", "--stdio"};
    }

    -- CSS Modules
    local cssmodules_ls_root_path = LSP_ROOT_PATH .. "/cssmodules_ls/node_modules/.bin"
    lspconfig.cssmodules_ls.setup {
        cmd = { cssmodules_ls_root_path .. "/cssmodules-language-server"};
    }
end


