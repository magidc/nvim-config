local ok, dap = pcall(require, "dap-python")

if not ok then
    return
end
dap.setup('/opt/anaconda3/envs/arelle/bin/python3')

