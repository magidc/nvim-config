local ok, gps = pcall(require, "nvim-gps")

if not ok then
    return
end

gps.setup()

require("lualine").setup({
    sections = {
        lualine_c = {{
            gps.get_location,
            cond = gps.is_available
        }}
    }
})
