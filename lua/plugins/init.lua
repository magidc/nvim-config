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

local plugins = {
    ---- UI
    {
        -- Start page
        "mhinz/vim-startify",
    },
    "aktersnurra/no-clown-fiesta.nvim",
    "kyazdani42/nvim-web-devicons",
    {
        "akinsho/bufferline.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons", "famiu/bufdelete.nvim" },
        config = function()
            require "plugins.configs.bufferline"
        end
    },
    "folke/which-key.nvim",
    {
        -- Smoother scroll
        "karb94/neoscroll.nvim",
        config = function()
            require "plugins.configs.neoscroll"
        end
    },
    {
        -- Better looking -- folding
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        config = function()
            require "plugins.configs.ufo"
        end
    },
    {
        -- Scroll bar
        "petertriho/nvim-scrollbar",
        config = function()
            require "plugins.configs.scrollbar"
        end
    },
    {
        -- Status bar
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "arkav/lualine-lsp-progress",
        },
        config = function()
            require "plugins.configs.lualine"
        end
    },
    {
        -- Pretty list for showing diagnostics, references, telescope results, quickfix and location lists
        "folke/trouble.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function()
            require "plugins.configs.trouble"
        end
    },
    {
        -- Code outline window for skimming and quick navigation
        "stevearc/aerial.nvim",
        config = function()
            require "plugins.configs.aerial"
        end
    },
    {
        -- Custom modes tu run commands with a common prefix
        "anuvyklack/hydra.nvim",
        config = function()
            require "plugins.configs.hydra"
        end
    },
    {
        -- Extends LSP function with external tools
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require "plugins.configs.null-ls"
        end
    },
    { -- Popup notifications
        "rcarriga/nvim-notify"
    },
    "mbbill/undotree",
    {
        -- Tree file explorer
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "kyazdani42/nvim-web-devicons" },
        config = function()
            require "plugins.configs.neotree"
        end
    },
    {
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            require "plugins.configs.lspsaga"
        end
    },
    ---- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "p00f/nvim-ts-rainbow",       -- Open/Close node coloring
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/playground", -- View treesitter information directly in Neovim
        },
        build = ":TSUpdate",
        config = function()
            require "plugins.configs.treesitter"
        end
    },

    ---- Utilities
    {
        -- Search engine
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require "plugins.configs.telescope"
        end
    },
    {
        -- Incremental selection expansion
        "terryma/vim-expand-region"
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
            require("telescope").load_extension("projects")
        end
    },
    -- {
    --     -- Add indentation guides even on blank lines
    --     "lukas-reineke/indent-blankline.nvim",
    --     config = function()
    --require "plugins.configs.indent"
    --end
    -- },
    {
        -- Autoclose brackets, parentheses...
        "windwp/nvim-autopairs",
        config = function()
            require "plugins.configs.autopairs"
        end
    },
    {
        -- Autochange open/close chars
        "kylechui/nvim-surround",
        config = function()
            require "plugins.configs.surround"
        end
    },
    {
        -- Colorize written color codes (#02F1AA, rgb(0,10,20)...)
        "norcalli/nvim-colorizer.lua",
        config = function()
            require "plugins.configs.colorizer"
        end
    },
    {
        -- Clipboard maanager
        "AckslD/nvim-neoclip.lua",
        dependencies = "nvim-telescope/telescope.nvim",
        config = function()
            require "plugins.configs.neoclip"
        end
    },
    {
        --- Improved terminal toggle
        "akinsho/toggleterm.nvim",
        version = "v2.*",
        config = function()
            require "plugins.configs.toggleterm"
        end
    },
    {
        -- Automatically highlighting other uses of the current word under the cursor
        "RRethy/vim-illuminate"
    },
    {
        --  Aims to provide a simple, unified, single tabpage interface that lets you easily review all changed files for any git rev
        "sindrets/diffview.nvim",
        dependencies = "nvim-lua/plenary.nvim"
    },
    {
        -- Project management
        "ahmedkhalf/project.nvim",
        dependencies = "nvim-telescope/telescope.nvim",
        config = function()
            require "plugins.configs.project"
        end
    },
    -- Comments
    {
        "numToStr/Comment.nvim",
        config = function()
            require "plugins.configs.comment"
        end
    },
    {
        "ggandor/leap.nvim",
        config = function()
            require "plugins.configs.leap"
        end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require "plugins.configs.todo"
        end
    },
    {
        "simrat39/rust-tools.nvim",
        dependencies = "nvim-lua/plenary.nvim"
    },

    ---- LSP
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-jdtls",
    {
        "williamboman/mason.nvim",
        config = function()
            require "plugins.configs.mason"
        end
    },

    -- Debug
    {
        "mfussenegger/nvim-dap",
        dependencies = "rcarriga/nvim-dap-ui",
        config = function()
            require "lsp.configs.dap"
        end
    },
    {
        "mfussenegger/nvim-dap-python",
        config = function()
            require "lsp.configs.dap-python"
        end
    },
    {
        "nvim-telescope/telescope-dap.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap" },
        config = function()
            require "plugins.configs.telescopedap"
        end
    },

    ---- Snippets
    {
        "L3MON4D3/LuaSnip",
    },
    {
        "rafamadriz/friendly-snippets",
    },
    ---- Completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            -- "hrsh7th/cmp-nvim-lsp-document-symbol",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            -- "lukas-reineke/cmp-under-comparator", -- Better sort completion items starting with underscore (Python)
        },
        config = function()
            require "plugins.configs.cmp"
        end
    },
    {
        -- VSCode like item type icons
        "onsails/lspkind.nvim",
    },
    {
        -- Show function signature when you type
        "ray-x/lsp_signature.nvim",
        config = function()
            require "plugins.configs.lspsignature"
        end
    },

    -- Tmux
    {
        "aserowy/tmux.nvim",
        config = function()
            require "plugins.configs.tmux"
        end
    },

    ---- Git
    {
        -- Add git related info in the signs columns and popups
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require "plugins.configs.gitsigns"
        end
    },
}
local theme = require("theme")
table.insert(plugins, theme.get_active_theme())

-- vim.api.nvim_echo({ { 'Active theme: ' .. theme.theme_name, "Normal" } }, true, {});
lazy.setup(plugins)
