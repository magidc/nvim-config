-- JAVA
local _jdtls, jdtls = pcall(require, "lsp.configs.jdtls")
if _jdtls and type(jdtls) ~= 'boolean' then
    vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = 'java',
        callback = jdtls.start,
        desc = "Starting Java language server"
    })
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Rust
local _rust, rust = pcall(require, "rust-tools")
if _rust then
    local mason_registry = require("mason-registry")
    local extension_path = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
    local codelldb_path = extension_path .. "adapter/codelldb"
    local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

    local opts = {
        dap = {
            adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        },
        server = {
            -- standalone = true,
            capabilities = capabilities,
            -- on_attach = function(_, bufnr)
            -- vim.keymap.set("n", "<Leader>k", rust.hover_actions.hover_actions, { buffer = bufnr })
            -- vim.keymap.set("n", "<Leader>a", rust.code_action_group.code_action_group, { buffer = bufnr })
            -- end,
        },
        tools = {
            hover_actions = {
                auto_focus = true,
            },
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

    -- -- Bash
    -- lspconfig.bashls.setup {}
    --
    -- -- Javascript/Typescript
    -- lspconfig.eslint.setup({
    --     capabilities = capabilities,
    --     settings = {
    --         packageManager = 'npm'
    --     },
    --     on_attach = function(client, bufnr)
    --         vim.api.nvim_create_autocmd("BufWritePre", {
    --             buffer = bufnr,
    --             command = "EslintFixAll",
    --         })
    --     end,
    -- })
    --
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
