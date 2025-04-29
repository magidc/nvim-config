local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")

if not ok then
	return
end

local theme = require("theme")

local opts = {
    defaults = {
    lazy = true, -- should plugins be lazy-loaded? No (load all plugins at start)
    version = nil,
    -- default `cond` you can use to globally disable a lot of plugins
    -- when running inside vscode for example
    cond = nil, ---@type boolean|fun(self:LazyPlugin):boolean|nil
    -- version = "*", -- enable this to try installing the latest stable versions of plugins
  },
}

local plugins = {
	---- UI
	theme.get_active_theme(),
	"mhinz/vim-startify", -- Start page
	"kyazdani42/nvim-web-devicons",
	"onsails/lspkind.nvim", -- VSCode like item type icons
	require("plugins.configs.bufferline"),
	require("plugins.configs.whichkey"),
	require("plugins.configs.neoscroll"), -- Smoother scrollfolke/which-key.nvim
	require("plugins.configs.ufo"), -- Better fold management
	require("plugins.configs.scrollbar"),
	require("plugins.configs.trouble"),
	require("plugins.configs.aerial"),
	-- require("plugins.configs.edgy"), -- Layout configurations
	require("plugins.configs.hydra"),
	"rcarriga/nvim-notify", -- Popup notifications
	"mbbill/undotree",
	require("plugins.configs.neotree"),
	require("plugins.configs.lualine"),
	require("plugins.configs.treesitter"),
	---- Utilities
	require("plugins.configs.telescope"),
	"terryma/vim-expand-region", -- Incremental selection expansion
	require("plugins.configs.autopairs"),
	require("plugins.configs.dial"), -- Extended increment/decrement functions
	require("plugins.configs.surround"), -- Autochange open/close chars
	require("plugins.configs.colorizer"), -- Colorize written color codes (#02F1AA, rgb(0,10,20)...)
	require("plugins.configs.neoclip"), -- Clipboard manager
	require("plugins.configs.toggleterm"), --- Improved terminal toggle
	require("plugins.configs.illuminate"), --- Automatically highlighting other uses of the word under the cursor
	require("plugins.configs.project"), -- Project management
	"sitiom/nvim-numbertoggle", -- Automatic switch to absolute line numbers when you are not in normal or visual mode, or focus is in other split
	require("plugins.configs.zen"),
	"chrisgrieser/nvim-spider",
  require("plugins.configs.matchup"),
	require("plugins.configs.textobjs"),
	require("plugins.configs.comment"),
	require("plugins.configs.flash"),
	require("plugins.configs.todo"),
	require("plugins.configs.harpoon"),
	require("plugins.configs.bigfile"),
	require("plugins.configs.splitjoin"), -- Quick split or join of lists
  "mg979/vim-visual-multi",
  
	---- Code
	require("plugins.configs.lspsaga"),
	require("plugins.configs.refactor"),
	require("plugins.configs.lens"),
	require("plugins.configs.conform"), -- Formatting tool
    require("plugins.configs.glance"),

	---- LSP/DAP
	require("plugins.configs.mason"),
	"neovim/nvim-lspconfig",
  require("lsp.configs.dap"),
	require("lsp.configs.java"),
	require("lsp.configs.rust"),
	require("lsp.configs.python"),
  require("lsp.configs.yaml"),

	---- Snippets
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",
	---- Completion
	-- require("plugins.configs.coq"),
	require("plugins.configs.cmp"),
	require("plugins.configs.lspsignature"),

--  require("plugins.configs.copilot"),
	-- Tmux
	require("plugins.configs.tmux"),
	---- Git
	require("plugins.configs.diffview"),
	require("plugins.configs.gitsigns"), -- Add git related info in the signs columns and popups

  { "lukas-reineke/indent-blankline.nvim", main = "ibl",  opts = {} },
  require("plugins.configs.indent"), -- Adding indent lines in the editor

  -- Integrate LazyGit into Neovim
  require("plugins.configs.lazygit"),

  --Heuristically determine the tabstops and spaces
  require("plugins.configs.tabstops"),

  -- Latex based on VimTex
  require("plugins.configs.latex"),
}

-- vim.api.nvim_echo({ { 'Active theme: ' .. theme.theme_name, "Normal" } }, true, {});
lazy.setup(plugins)
