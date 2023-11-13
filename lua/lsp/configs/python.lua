return {
    "mfussenegger/nvim-dap-python",
	ft = { "py" },
    config = function()
        require("dap-python").setup("/opt/anaconda3/envs/arelle/bin/python3")
    end,
}
