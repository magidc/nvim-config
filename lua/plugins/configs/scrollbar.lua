local _scrollbar, scrollbar = pcall(require, "scrollbar")

if not _scrollbar then
    return
end

local colors = require("theme").colors

scrollbar.setup {
    handle = {
        color = colors.grey12
    }
}
