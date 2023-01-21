local M = {}

M.colors = {
    bg = "#2e3440",
    fg = "#ECEFF4",
    red = "#bf616a",
    orange = "#d08770",
    yellow = "#ebcb8b",
    blue = "#5e81ac",
    green = "#a3be8c",
    cyan = "#88c0d0",
    magenta = "#b48ead",
    purple = "#534671",
    pink = "#FFA19F",
    grey1 = "#f8fafc",
    grey2 = "#f0f1f4",
    grey3 = "#eaecf0",
    grey4 = "#d9dce3",
    grey5 = "#c4c9d4",
    grey6 = "#b5bcc9",
    grey7 = "#929cb0",
    grey8 = "#8e99ae",
    grey9 = "#74819a",
    grey10 = "#616d85",
    grey11 = "#464f62",
    grey12 = "#3a4150",
    grey13 = "#333a47",
    grey14 = "#242932",
    grey15 = "#1e222a",
    grey16 = "#1c1f26",
    grey17 = "#0f1115",
    grey18 = "#0d0e11",
    grey19 = "#020203"
}

local function loadNoClownFiesta()
    vim.cmd [[colorscheme no-clown-fiesta]]
    require("no-clown-fiesta").setup({
        transparent = false, -- Enable this to disable the bg color
        styles = {
            -- You can set any of the style values specified for `:h nvim_set_hl`
            comments = {},
            keywords = {},
            functions = {},
            variables = {},
            type = { bold = true },
        },
    })
end


M.init = function(theme_name)
    M.theme_name = theme_name
    local _ok, theme = pcall(require, M.theme_name)

    if M.theme_name == 'onenord' then
        theme.setup {
            borders = true,
            fade_nc = false,
            styles = {
                comments = "italic",
                strings = "NONE",
                keywords = "NONE",
                functions = "italic",
                variables = "bold",
                diagnostics = "underline"
            },
            disable = {
                background = false,
                cursorline = false,
                eob_lines = true
            },
            colors = {},
        }
    elseif M.theme_name == 'tokyonight' then
        theme.setup({
            style = 'night',
            on_colors = function(colors)
                colors.bg_dark = '#000000'
                colors.bg = '#11121D'
            end
        })
        theme.load()
    elseif M.theme_name == 'onedark' then
        theme.setup {
            style = 'warm',
            transparent = true, -- Show/hide background
            code_style = {
                comments = 'italic',
                keywords = 'none',
                functions = 'none',
                strings = 'none',
                variables = 'none'
            },
            lualine = {
                transparent = true, -- lualine center bar transparency
            },
        }
        theme.load()
        --loadNoClownFiesta()
    elseif M.theme_name == 'moonfly' then
        vim.cmd [[colorscheme moonfly]]
    elseif M.theme_name == 'material' then
        vim.g.material_style = "oceanic"
        vim.cmd 'colorscheme material'
    elseif M.theme_name == 'onedarkpro' then
        vim.o.background = "dark"
        theme.load()
    elseif M.theme_name == 'tokyodark' then
        vim.g.tokyodark_transparent_background = false
        vim.g.tokyodark_enable_italic_comment = true
        vim.g.tokyodark_enable_italic = true
        vim.g.tokyodark_color_gamma = "0.0"
        vim.cmd 'colorscheme tokyodark'
    elseif M.theme_name == 'catppuccin' then
        vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
        vim.cmd [[colorscheme catppuccin]]
    elseif M.theme_name == 'dracula' then
        theme.setup {}
        theme.load()
    elseif M.theme_name == 'draculanight' then
        theme.setup {}
        theme.load()
    end
end

return M
