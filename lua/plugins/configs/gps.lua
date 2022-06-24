local ok, gps = pcall(require, "nvim-gps")

if not ok then
    return
end

gps.setup()

