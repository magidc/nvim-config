local utils = require("utils")

-- No remote plugins (rplugin) are used: skip the provider detection
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

local options = {
	background = "dark",
	breakindent = true, -- Enable break indent
	clipboard = "unnamed,unnamedplus", -- Use system clipboard
	completeopt = "noinsert,menuone,noselect", -- Set completeopt to have a better completion experience
	confirm = true,
	cursorline = true,
	expandtab = true,
	foldcolumn = "1",
	foldenable = true,
	foldexpr = "v:lua.vim.treesitter.foldexpr()",
	foldlevel = 99,
	foldlevelstart = 99,
	foldmethod = "expr",
	foldtext = "", -- Show the first line of a closed fold with its highlighting
	ignorecase = true, -- Case insensitive searching UNLESS /C or capital in search
	laststatus = 3,
	mouse = "a", -- Enable mouse mode
	number = true, -- Make line numbers default
	pumheight = 10,
	relativenumber = true,
	scrolloff = 5,
	shiftround = true,
	shiftwidth = 2,
	showmode = false,
	sidescrolloff = 5,
	signcolumn = "yes",
	smartcase = true,
	softtabstop = 2,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	tabstop = 2,
	termguicolors = true,
	ttimeoutlen = 0,
	title = true,
	undodir = os.getenv("HOME") .. "/.vim/undodir",
	undofile = true, -- Save undo history
	updatetime = 100, -- Decrease update time
	winborder = "rounded", -- Border of floating windows (LSP hover, diagnostics...)
	wrap = false,
}

for key, value in pairs(options) do
	vim.opt[key] = value
end

vim.opt.shortmess:append("c")

vim.cmd([[set fcs=eob:\ ]])

utils.set_indent_sizes({ go = 4, python = 4, rust = 4, cpp = 4, c = 4, make = 4, lua = 4, java = 4, json = 4 })

-- Lua files are formatted by stylua with tabs (stylua.toml): indent Lua buffers with tabs too
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("LuaTabs", { clear = true }),
	pattern = "lua",
	callback = function(args)
		vim.bo[args.buf].expandtab = false
	end,
})

-- Disable automatic line breaks
vim.opt.formatoptions:remove({ "t", "c", "a", "r", "o" })

-- Space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- UI theme
require("theme").set_active_theme("tokyonight")

-- Not apply background color when running inside tmux. My tmux config changes background color whether the pane is
-- active or not, so I want to use that instead of neovim's background color.
if vim.env.TMUX then
	local function clear_background()
		local groups = { "Normal", "NormalNC", "EndOfBuffer", "SignColumn", "FoldColumn" }
		for _, g in ipairs(groups) do
			vim.api.nvim_set_hl(0, g, { bg = "none", update = true })
		end
	end
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = vim.api.nvim_create_augroup("TmuxBackground", { clear = true }),
		callback = clear_background,
	})
	-- The theme is loaded later by lazy.setup(), and tokyonight's theme.load() does not trigger ColorScheme
	vim.schedule(clear_background)
end
