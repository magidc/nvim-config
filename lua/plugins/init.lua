local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({ { "Failed to clone lazy.nvim:\n", "ErrorMsg" }, { out, "WarningMsg" } }, true, {})
	end
end
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")

if not ok then
	return
end

local theme = require("theme")
local plugins = {
	---- UI
	theme.get_active_theme(),
	"mhinz/vim-startify", -- Start page
	"nvim-tree/nvim-web-devicons",
	require("plugins.configs.bufferline"),
	"folke/which-key.nvim",
	require("plugins.configs.neoscroll"), -- Smoother scroll
	require("plugins.configs.scrollbar"),
	require("plugins.configs.trouble"),
	require("plugins.configs.aerial"),
	-- require("plugins.configs.edgy"), -- Layout configurations
	require("plugins.configs.hydra"),
	require("plugins.configs.notify"), -- Popup notifications
	require("plugins.configs.neotree"),
	require("plugins.configs.lualine"),
	require("plugins.configs.treesitter"),
	---- Utilities
	require("plugins.configs.telescope"),
	require("plugins.configs.autopairs"),
	require("plugins.configs.dial"), -- Extended increment/decrement functions
	require("plugins.configs.surround"), -- Autochange open/close chars
	-- require("plugins.configs.colorizer"), -- Colorize written color codes (#02F1AA, rgb(0,10,20)...)
	require("plugins.configs.neoclip"), -- Clipboard manager
	require("plugins.configs.toggleterm"), --- Improved terminal toggle
	require("plugins.configs.illuminate"), --- Automatically highlighting other uses of the word under the cursor
	require("plugins.configs.project"), -- Project management
	"sitiom/nvim-numbertoggle", -- Automatic switch to absolute line numbers when you are not in normal or visual mode, or focus is in other split
	require("plugins.configs.zen"),
	"chrisgrieser/nvim-spider", -- Subwords motions
	require("plugins.configs.textobjs"),
	require("plugins.configs.substitute"), -- Replace with paste
	require("plugins.configs.comment"),
	require("plugins.configs.flash"),
	require("plugins.configs.todo"),
	require("plugins.configs.bigfile"),
	require("plugins.configs.splitjoin"), -- Quick split or join of lists
	require("plugins.configs.expandregion"), -- Selection expansion fallback
	require("plugins.configs.visualmulti"), -- Multiple cursors
	---- Code
	require("plugins.configs.lspsaga"),
	require("plugins.configs.conform"), -- Formatting tool
	require("plugins.configs.glance"),

	---- LSP/DAP
	require("plugins.configs.mason"),
	"neovim/nvim-lspconfig",
	require("lsp.configs.dap"),
	require("lsp.configs.java"),

	---- Completion
	-- require("plugins.configs.coq"),
	-- require("plugins.configs.cmp"),
	require("plugins.configs.blink"),
	-- require("plugins.configs.lspsignature"), -- blink.cmp shows the signature help
	-- Tmux
	require("plugins.configs.tmux"),
	---- Git
	require("plugins.configs.diffview"),
	require("plugins.configs.gitsigns"), -- Add git related info in the signs columns and popups
}

-- vim.api.nvim_echo({ { 'Active theme: ' .. theme.theme_name, "Normal" } }, true, {});
lazy.setup(plugins, { rocks = { enabled = false } })

-- Built-in :Undotree, after lazy.setup() because lazy resets 'runtimepath'
vim.cmd.packadd("nvim.undotree")
