local ok, dapui = pcall(require, "dapui")

if not ok then
    return
end

require("telescope").load_extension("dap")
