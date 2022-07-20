
local function start_language_server(pattern, callback)
    vim.api.nvim_create_autocmd({"FileType"}, {
        pattern = pattern,
        callback =  callback,
        desc = "Start language server: " .. pattern
    })
end

local _jdtls, jdtls = pcall(require, "lsp.configs.jdtls")
if _jdtls and type(jdtls) ~= 'boolean' then
    start_language_server('java', jdtls.start)
end
