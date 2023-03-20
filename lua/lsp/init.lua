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
        },
    }
    rust.setup(opts)
end

local _lspconfig, lspconfig = pcall(require, "lspconfig")
if _lspconfig then
    -- Python
    lspconfig.pyright.setup {}

    -- LUA
    lspconfig.lua_ls.setup {
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
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Bash
    lspconfig.bashls.setup {}

    -- Javascript/Typescript
    lspconfig.eslint.setup({
        capabilities = capabilities,
        settings = {
            packageManager = 'npm'
        },
        on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "EslintFixAll",
            })
        end,
    })

    -- HTML
    lspconfig.html.setup {
        capabilities = capabilities,
    }

    -- CSS
    lspconfig.cssls.setup {
        capabilities = capabilities
    }

    -- Dockerfile
    lspconfig.dockerls.setup {
        capabilities = capabilities
    }

    -- Docker compose
    lspconfig.docker_compose_language_service.setup {
        capabilities = capabilities
    }
end
