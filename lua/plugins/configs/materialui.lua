local ok, material = pcall(require, "material")

if not ok then
    return
end

material.setup({
	lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )
})
