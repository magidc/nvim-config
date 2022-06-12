local ok, lualine = pcall(require, "lualine")

if not ok then
    return
end

lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'onenord',
        --theme ='tokyonight',
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true
    },
    -- Autosession plugin integration
    sections = {lualine_c = {require('auto-session-library').current_session_name}}
}