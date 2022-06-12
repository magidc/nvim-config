local _scrollbar, scrollbar = pcall(require, "scrollbar")
local _onenord, onenord = pcall(require, "onenord.colors")

if not _scrollbar then
    return
end

if _onenord then
    local colors = onenord.load()
    scrollbar.setup {
        handle = {
            color = colors.red,
        }
    }
    return
end

local _tokyonight, tokyonight = pcall(require, "tokyonight.colors")
if _tokyonight then
    local colors = tokyonight.setup()
    scrollbar.setup {
        handle = {
            color = colors.blue,
        }
    }
    return
end
