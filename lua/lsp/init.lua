local function start_language_server(pattern, callback)
    vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = pattern,
        callback = callback,
        desc = "Start language server: " .. pattern
    })
end

-- JAVA
local _jdtls, jdtls = pcall(require, "lsp.configs.jdtls")
if _jdtls and type(jdtls) ~= 'boolean' then
    start_language_server('java', jdtls.start)
end

-- Rust
local _rust, rust = pcall(require, "rust-tools")
if _rust then
    local opts = {
        server = {
            standalone = true,
            cmd = { LSP_ROOT_PATH .. "/rust-analyzer/rust-analyzer" };
        },
    }
    rust.setup(opts)
end

local _lspconfig, lspconfig = pcall(require, "lspconfig")
if _lspconfig then
    -- Python
    lspconfig.pyright.setup {
        cmd = { LSP_ROOT_PATH .. "/pyright/node_modules/.bin/pyright-langserver", "--stdio" };
    }

    -- LUA
    local lua_language_server_root_path = LSP_ROOT_PATH .. "/lua-language-server/extension/server/bin"
    lspconfig.sumneko_lua.setup {
        cmd = { lua_language_server_root_path .. "/lua-language-server", "-E",
            lua_language_server_root_path .. "/main.lua" };
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        }
    }

    -- Bash
    lspconfig.bashls.setup {
        cmd = { LSP_ROOT_PATH .. "/bash-language-server/node_modules/.bin/bash-language-server" };
    }

    -- Dockerfile
    lspconfig.dockerls.setup {
        cmd = { LSP_ROOT_PATH .. "/dockerfile-language-server/node_modules/.bin/docker-langserver" };
    }
    -- HTML
    local html_root_path = LSP_ROOT_PATH .. "/html-lsp/node_modules/.bin"
    lspconfig.html.setup {
        cmd = { html_root_path .. "/vscode-html-language-server", "--stdio" };
    }

    -- JSON
    lspconfig.jsonls.setup {
        cmd = { html_root_path .. "/vscode-json-language-server", "--stdio" };
    }

    -- CSS
    lspconfig.cssls.setup {
        cmd = { html_root_path .. "/vscode-css-language-server", "--stdio" };
    }

    -- Markdown
    lspconfig.cssls.setup {
        cmd = { html_root_path .. "/vscode-markdown-language-server", "--stdio" };
    }

    -- Javascript/Typescript
    lspconfig.eslint.setup {
        cmd = { html_root_path .. "/vscode-eslint-language-server", "--stdio" };
    }
    -- CSS Modules
    local cssmodules_ls_root_path = LSP_ROOT_PATH .. "/cssmodules-language-server/node_modules/.bin"
    lspconfig.cssmodules_ls.setup {
        cmd = { cssmodules_ls_root_path .. "/cssmodules-language-server" };
    }
end
