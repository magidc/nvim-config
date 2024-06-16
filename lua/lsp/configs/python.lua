return {
    "mfussenegger/nvim-dap-python",
	ft = { "py" },
    config = function()
        require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
    end,
}
