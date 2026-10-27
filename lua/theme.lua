local M = {}

M.colors = { red = "#bf616a" }

local themes = {
	onenord = {
		"rmehri01/onenord.nvim",
		config = function()
			require("onenord").setup({
				borders = true,
				fade_nc = false,
				styles = {
					comments = "italic",
					strings = "NONE",
					keywords = "NONE",
					functions = "italic",
					variables = "bold",
					diagnostics = "underline",
				},
				disable = {
					background = false,
					cursorline = false,
					eob_lines = true,
				},
				colors = {},
			})
		end,
	},
	tokyonight = {
		"folke/tokyonight.nvim",
		config = function()
			local theme = require("tokyonight")
			theme.setup({
				style = "night",
				on_colors = function(colors)
					colors.bg_dark = "#000000"
					colors.bg = "#11121D"
				end,
			})
			theme.load()
		end,
	},
	onedark = {
		"navarasu/onedark.nvim",
		config = function()
			local theme = require("onedark")
			theme.setup({
				style = "deep",
				transparent = false, -- Show/hide background
				code_style = {
					comments = "italic",
					keywords = "none",
					functions = "none",
					strings = "none",
					variables = "none",
				},
				lualine = {
					transparent = true, -- lualine center bar transparency
				},
			})
			theme.load()
		end,
	},
	palenightfall = {
		"JoosepAlviste/palenightfall.nvim",
		config = function()
			require("palenightfall").setup({})
		end,
	},
	nordic = {
		"AlexvZyl/nordic.nvim",
		config = function()
			require("nordic").setup({})
		end,
	},
	onedarkpro = {
		"olimorris/onedarkpro.nvim",
		config = function()
			vim.o.background = "dark"
			require("onedarkpro").load()
		end,
	},
	tokyodark = {
		"tiagovla/tokyodark.nvim",
		config = function()
			vim.g.tokyodark_transparent_background = false
			vim.g.tokyodark_enable_italic_comment = true
			vim.g.tokyodark_enable_italic = true
			vim.g.tokyodark_color_gamma = "0.0"
			vim.cmd("colorscheme tokyodark")
		end,
	},
	moonfly = {
		"bluz71/vim-moonfly-colors",
		config = function()
			vim.cmd([[colorscheme moonfly]])
		end,
	},
	dracula = {
		"Mofiqul/dracula.nvim",
		config = function()
			local theme = require("dracula")
			theme.setup({})
			theme.load()
		end,
	},
	draculanight = {
		"magidc/draculanight",
		config = function()
			local theme = require("draculanight")
			theme.setup({})
			theme.load()
		end,
	},
	catppuccin = {
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
	material = {
		"marko-cerovac/material.nvim",
		config = function()
			require("plugins.configs.materialui")
		end,
	},
	gruvbox = {
		"sainnhe/gruvbox-material",
		config = function()
			vim.o.background = "dark"
			vim.g.gruvbox_material_enable_italic = true
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_foreground = "material"
			vim.g.gruvbox_material_cursor = "auto"
			vim.g.gruvbox_material_show_eob = 0
			vim.g.gruvbox_material_ui_contrast = "high"
			vim.g.gruvbox_material_float_style = "bright"
			vim.g.gruvbox_material_transparent_background = 2
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
}

M.set_active_theme = function(theme_name)
	M.theme_name = theme_name
end

M.get_active_theme = function()
	local theme = themes[M.theme_name]
	if not theme then
		vim.notify(
			("theme.lua: unknown theme '%s', using tokyonight"):format(tostring(M.theme_name)),
			vim.log.levels.WARN
		)
		M.theme_name = "tokyonight" -- lualine reads it as its theme name
		theme = themes.tokyonight
	end
	theme.lazy = false
	theme.priority = 1000
	return theme
end

return M
