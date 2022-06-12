local _M = {}

_M.colors = {
    bg = "#2e3440",
    fg = "#ECEFF4",
    red = "#bf616a",
    orange = "#d08770",
    yellow = "#ebcb8b",
    blue = "#5e81ac",
    green = "#a3be8c",
    cyan = "#88c0d0",
    magenta = "#b48ead",
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
    grey19 = "#020203",
}

_M.init = function()
    local _onenord, onenord = pcall(require, "onenord")
    local _tokyonight, tokyonight = pcall(require, "tokyonight.theme")
    
    if _onenord then
        onenord.setup {
            borders = true,
            fade_nc = false,
            styles = {
                comments = "italic",
                strings = "NONE",
                keywords = "NONE",
                functions = "italic",
                variables = "bold",
                diagnostics = "underline",
            },
            disable = {
                background = false,
                cursorline = false,
                eob_lines = true,
            },
            colors = {},
            custom_highlights = {
                VertSplit = { fg = _M.colors.grey14 },
                BufferLineIndicatorSelected = { fg = _M.colors.cyan, bg = _M.colors.bg },
                BufferLineFill = { fg = _M.colors.fg, bg = _M.colors.grey14 },
                WhichKeyFloat = { bg = _M.colors.grey14 },
                GitSignsAdd = { fg = _M.colors.green },
                GitSignsChange = { fg = _M.colors.orange },
                GitSignsDelete = { fg = _M.colors.red },

                NormalFloat = { bg = _M.colors.grey14 },
                FloatBorder = { bg = _M.colors.grey14, fg = _M.colors.grey14 },

                Pmenu = { bg = _M.colors.grey14 },
                PMenuThumb = { bg = _M.colors.grey16 },

                LspFloatWinNormal = { fg = _M.colors.fg, bg = _M.colors.grey14 },
                LspFloatWinBorder = { fg = _M.colors.grey14 },

                IndentBlanklineChar = { fg = _M.colors.grey12, style = "nocombine" },
                IndentBlanklineContextChar = { fg = _M.colors.magenta, style = "nocombine" },

                TSVariable = { fg = _M.colors.blue },
                TSVariableBuiltin = { fg = _M.colors.blue },
            },
        }
    elseif _tokyonight then
        tokyonight.setup {
            style = "day"
        }
    end
        
end

return _M
