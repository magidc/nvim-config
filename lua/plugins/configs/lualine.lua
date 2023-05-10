local _lualine, lualine = pcall(require, "lualine")

if not _lualine then
    return
end

lualine.setup({
    options = {
        icons_enabled = true,
        theme = require("theme").theme_name,
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true
    },
    sections = {
        lualine_c = {
            "lsp_progress",
        }
    }
})
