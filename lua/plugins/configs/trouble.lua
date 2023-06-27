return {
    -- Pretty list for showing diagnostics, references, telescope results, quickfix and location lists
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
        require("trouble").setup({
            mode = "workspace_diagnostics",
            "document_diagnostics",
            "quickfix",
            "lsp_references",
            "loclist",
        })
    end,
}
