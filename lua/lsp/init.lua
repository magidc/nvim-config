
local function start_language_server(pattern, callback)
    vim.api.nvim_create_autocmd({"FileType"}, {
        pattern = pattern,
        callback =  callback,
        desc = "Start language server: " .. pattern
    })
end


start_language_server('java', require("lsp.configs.jdtls").start)
