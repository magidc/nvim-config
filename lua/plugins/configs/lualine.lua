local ok, lualine = pcall(require, "lualine")

if not ok then
    return
end

lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'horizon',
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true
    }
}