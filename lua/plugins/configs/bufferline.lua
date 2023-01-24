local ok, bufferline = pcall(require, "bufferline")
local colors = require("theme").colors

if not ok then
    return
end

--set termguicolors
bufferline.setup {
    options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        numbers = "none",
        offsets = {
            {
                filetype = "neo-tree",
                text = function()
                    return vim.fn.getcwd()
                end,
                highlight = "Directory",
                text_align = "left"
            }
        },
        separator_style = "thin",
        sort_by = 'insert_after_current'
    },
    highlights = {
        buffer_selected = {
            bold = true,
            italic = false,
        },
        numbers_selected = {
            bold = true,
            italic = false,
        },
        close_button_selected = {
        },
        diagnostic_selected = {
            bold = true,
            italic = false,
        },
        hint_selected = {
            bold = true,
            italic = false,
        },
        hint_diagnostic_selected = {
            bold = true,
            italic = false,
        },
        info_selected = {
            bold = true,
            italic = false,
        },
        info_diagnostic_selected = {
            bold = true,
            italic = false,
        },
        warning_selected = {
            bold = true,
            italic = false,
        },
        warning_diagnostic_selected = {
            bold = true,
            italic = false,
        },
        error_selected = {
            bold = true,
            italic = false,
        },
        error_diagnostic_selected = {
            bold = true,
            italic = false,
        },
        duplicate_selected = {
        },
        duplicate_visible = {
        },
        duplicate = {
        },
        pick_selected = {
            bold = true,
            italic = false,
        },
        pick_visible = {
            bold = true,
            italic = false,
        },
        pick = {
            bold = true,
            italic = false,
        }
    }
}
