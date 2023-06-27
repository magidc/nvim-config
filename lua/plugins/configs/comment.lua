return {
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup({
            padding = true,
            sticky = true,
            ignore = nil,
            toggler = {
                line = "<c-m>",
                block = "<c-n>",
            },
            opleader = {
                line = "<c-m>",
                block = "<c-n>",
            },
            mappings = {
                basic = true,
                extra = true,
                extended = false,
            },
            pre_hook = nil,
            post_hook = nil,
        })
    end,
}
