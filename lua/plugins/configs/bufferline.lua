local ok, bufferline = pcall(require, "bufferline")

if not ok then
    return
end

local colors = require("theme").colors

bufferline.setup {
    options = {
        mode = "buffers",
        numbers = "none",
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator_icon = "▎",
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        name_formatter = function(buf)
            if buf.name:match "%.md" then
                return vim.fn.fnamemodify(buf.name, ":t:r")
            end
        end,
        max_name_length = 18,
        max_prefix_length = 15,
        tab_size = 25,
        diagnostics = false,
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            return " "
        end,
        offsets = { { filetype = "NvimTree", text = "" } },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_buffer_default_icon = true,
        show_close_icon = false,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = { "", "" },
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        sort_by = "insert_at_end",
    },
    highlights = {
        fill = {
            guifg = colors.fg,
            guibg = colors.grey19,
        },
        background = {
            guifg = colors.fg,
            guibg = colors.grey12,
        },
        buffer_visible = {
            guifg = colors.fg,
            guibg = colors.grey12,
        },
        buffer_selected = {
            gui = "bold",
            guifg = colors.fg,
            guibg = colors.bg,
        },
        separator = {
            guifg = colors.cyan,
            guibg = colors.bg,
        },
        separator_selected = {
            guifg = colors.cyan,
            guibg = colors.bg,
        },
        separator_visible = {
            guifg = colors.cyan,
            guibg = colors.bg,
        },
        close_button = {
            guifg = colors.fg,
            guibg = colors.grey12,
        },
        close_button_selected = {
            guifg = { attribute = "fg", highlight = "normal" },
            guibg = { attribute = "bg", highlight = "normal" },
        },
        close_button_visible = {
            guifg = { attribute = "fg", highlight = "normal" },
            guibg = { attribute = "bg", highlight = "normal" },
        },
        duplicate = {
            guifg = colors.grey9,
            guibg = colors.grey12,
        },
        duplicate_selected = {
            guifg = colors.grey9,
            gui = "italic",
            guibg = colors.bg,
        },
        duplicate_visible = {
            guifg = colors.grey9,
            gui = "italic",
            guibg = colors.grey12,
        },
        indicator_selected = {
            guifg = colors.cyan,
            guibg = colors.bg,
        },
        modified = {
            guifg = colors.grey11,
            guibg = colors.grey12,
        },
        modified_visible = {
            guifg = colors.grey11,
            guibg = colors.grey12,
        },
        modified_selected = {
            guifg = colors.grey10,
            guibg = colors.bg,
        },
    },
}
