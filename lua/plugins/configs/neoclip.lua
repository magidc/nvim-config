local ok, neoclip = pcall(require, "neoclip")

if not ok then
    return
end

neoclip.setup {}
