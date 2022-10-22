local ok, comment = pcall(require, "Comment")

if not ok then
    return
end

comment.setup {
    padding = true,
    sticky = true,
    ignore = nil,
    toggler = {
        line = "<c-/>",
        block = "<c-]>",
    },
    opleader = {
        line = "<c-a-/>",
        block = "<c-a-]>",
    },
    mappings = {
        basic = true,
        extra = true,
        extended = false,
    },
    pre_hook = nil,
    post_hook = nil,
}
