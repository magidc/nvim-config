local _jdtls, jdtls  = pcall(require, "jdtls")
local _handlers, handlers = pcall(require, "lsp.handlers")

if not _jdtls or not _handlers then
    return
end

local function map_java_keys(bufnr)
    local opts = { noremap = true, silent = true }
    local bufmap = vim.api.nvim_buf_set_keymap
    bufmap(bufnr, "n", "<leader>uo", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
    bufmap(bufnr, "n", "<leader>ut", "<Cmd>lua require'jdtls'.test_class({ config = { console = 'console' }})<CR>", opts)
    bufmap(
      bufnr,
      "n",
      "<leader>uT",
      "<Cmd>lua require'jdtls'.test_nearest_method({ config = { console = 'console' }})<CR>",
      opts
    )
    bufmap(bufnr, "v", "<leader>ue", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
    bufmap(bufnr, "n", "<leader>ue", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
    bufmap(bufnr, "v", "<leader>um", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
  end

local on_attach = function(client, bufnr)
    handlers.set_document_higlighting(client)
    handlers.set_signature_helper(client)
    handlers.set_hover_border(client)
    --map_keys(bufnr)
    if client.name == "jdt.ls" then
      jdtls.setup_dap({ hotcodereplace = "auto" })
      jdtls.setup.add_commands()
      -- Auto-detect main and setup dap config
      require("jdtls.dap").setup_dap_main_class_configs()
      map_java_keys(bufnr)
    end
  end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = "/home/magidc/.local/share/eclipse//" .. project_name

local config = {
        cmd = {
          'java', 
          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Dosgi.bundles.defaultStartLevel=4',
          '-Declipse.product=org.eclipse.jdt.ls.core.product',
          '-Dlog.protocol=true',
          '-Dlog.level=ALL',
          '-Xms1g',
          '--add-modules=ALL-SYSTEM',
          '--add-opens',
          'java.base/java.util=ALL-UNNAMED',
          '--add-opens',
          'java.base/java.lang=ALL-UNNAMED', 
          '-jar','/home/magidc/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
          '-configuration','/home/magidc/.local/share/nvim/lsp_servers/jdtls/config_linux', 
          '-data',workspace_dir},
        flags = {
            debounce_text_changes = 150,
            allow_incremental_sync = true
        },
        handlers = {},
        root_dir = require("jdtls.setup").find_root({"build.gradle", "pom.xml", ".git"}),

        on_init = on_init,
        init_options = {
            bundles = bundles
        },
        capabilities = handlers.capabilities,
        on_attach = on_attach,
        settings = {
            java = {
                signatureHelp = {
                    enabled = true
                },
                completion = {
                    favoriteStaticMembers = {
                      "org.hamcrest.MatcherAssert.assertThat",
                      "org.hamcrest.Matchers.*",
                      "org.hamcrest.CoreMatchers.*",
                      "org.junit.jupiter.api.Assertions.*",
                      "java.util.Objects.requireNonNull",
                      "java.util.Objects.requireNonNullElse",
                      "org.mockito.Mockito.*"}
                },
                sources = {
                    organizeImports = {
                        starThreshold = 9999,
                        staticStarThreshold = 9999
                    }
                },
                codeGeneration = {
                    toString = {
                        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                    }
                }
            }
        }
    }

local M = {}

M.start = function()
    jdtls.start_or_attach(config)
end

return M
