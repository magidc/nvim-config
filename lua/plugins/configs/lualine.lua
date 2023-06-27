return {
    -- Status bar
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "arkav/lualine-lsp-progress",
    },
    config = function()
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = require("theme").theme_name,
                disabled_filetypes = {},
                always_divide_middle = true,
                globalstatus = true,
            },
            sections = {
                lualine_c = {
                    "lsp_progress",
                    "aerial",
                },
            },
        })
    end,
}
