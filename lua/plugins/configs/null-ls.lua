return {
    -- Extends LSP function with external tools
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.xmllint,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.diagnostics.hadolint, -- For Dockerfiles
            },
        })
    end,
}
