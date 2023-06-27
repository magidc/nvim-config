return {
    -- Scroll bar
    "petertriho/nvim-scrollbar",
    config = function()
        require("scrollbar").setup({
            handle = {
                color = require("theme").colors.red,
            },
        })
    end,
}
