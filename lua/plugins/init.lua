local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
        install_path }
end
vim.cmd [[packadd packer.nvim]]

local ok, packer = pcall(require, "packer")

if not ok then
    return
end

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float {
                border = "single"
            }
        end,
        prompt_border = "single"
    },
    git = {
        clone_timeout = 600
    },
    auto_clean = true,
    compile_on_sync = false
}

require("packer").startup(function(use)
    ---- Package manager
    use "wbthomason/packer.nvim"

    ---- UI Themes
    -- use "rmehri01/onenord.nvim"
    -- use "folke/tokyonight.nvim"
    -- use "navarasu/onedark.nvim"
    -- use "olimorris/onedarkpro.nvim"
    -- use "tiagovla/tokyodark.nvim"
    -- use "bluz71/vim-moonfly-colors"
    -- use "Mofiqul/dracula.nvim"
    use "magidc/draculanight"
    -- use {
    --     "catppuccin/nvim",
    --     as = "catppuccin"
    -- }
    -- use {
    --     "marko-cerovac/material.nvim",
    --     config = require "plugins.configs.materialui"
    -- }
    ---- UI
    use {
        -- Start page
        "mhinz/vim-startify",
    }
    use "kyazdani42/nvim-web-devicons"
    use {
        "akinsho/bufferline.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = require "plugins.configs.bufferline"
    }
    use "folke/which-key.nvim"
    use {
        -- Smoother scroll
        "karb94/neoscroll.nvim",
        config = require "plugins.configs.neoscroll"
    }
    use {
        -- Better looking folding
        "kevinhwang91/nvim-ufo",
        requires = "kevinhwang91/promise-async",
        config = require "plugins.configs.ufo"
    }
    use {
        -- Scroll bar
        "petertriho/nvim-scrollbar",
        config = require "plugins.configs.scrollbar"
    }
    use {
        -- Status bar
        "nvim-lualine/lualine.nvim",
        requires = {
            "arkav/lualine-lsp-progress",
            "SmiteshP/nvim-gps",
        },
        config = require "plugins.configs.lualine"
    }
    use {
        -- Status line component that shows context of the current cursor position in file.
        "SmiteshP/nvim-gps",
        requires = "nvim-treesitter/nvim-treesitter",
        config = require "plugins.configs.gps"
    }
    use {
        -- Pretty list for showing diagnostics, references, telescope results, quickfix and location lists
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = require "plugins.configs.trouble"
    }
    use {
        -- Code outline window for skimming and quick navigation
        "stevearc/aerial.nvim",
        config = require "plugins.configs.aerial"
    }
    use {
        -- Custom modes tu run commands with a common prefix
        "anuvyklack/hydra.nvim",
        config = require "plugins.configs.hydra"
    }
    use {
        -- Extends LSP function with external tools
        "jose-elias-alvarez/null-ls.nvim",
        config = require "plugins.configs.null-ls"
    }
    use "rcarriga/nvim-notify" -- Popup notifications
    use {
        -- Tree file explorer
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
        config = require "plugins.configs.neotree"
    }
    use {
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = require "plugins.configs.lspsaga"
    }
    ---- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        requires = {
            "p00f/nvim-ts-rainbow", -- Open/Close node coloring
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/playground", -- View treesitter information directly in Neovim
        },
        run = ":TSUpdate",
        config = require "plugins.configs.treesitter"
    }

    ---- Utilities
    -- use "lewis6991/impatient.nvim" -- Startup performance enhancer

    use {
        -- Search engine
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = require "plugins.configs.telescope"
    }
    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make"
    }
    use {
        -- Add indentation guides even on blank lines
        "lukas-reineke/indent-blankline.nvim",
        config = require "plugins.configs.indent"
    }
    use {
        -- Autoclose brackets, parentheses...
        "windwp/nvim-autopairs",
        config = require "plugins.configs.autopairs"
    }
    use {
        -- Autochange open/close chars
        "kylechui/nvim-surround",
        config = require "plugins.configs.surround"
    }
    use {
        -- Colorize written color codes (#02F1AA, rgb(0,10,20)...)
        "norcalli/nvim-colorizer.lua",
        config = require "plugins.configs.colorizer"
    }
    use {
        -- Clipboard maanager
        "AckslD/nvim-neoclip.lua",
        requires = "nvim-telescope/telescope.nvim",
        config = require "plugins.configs.neoclip"
    }
    use {
        --- Improved terminal toggle
        "akinsho/toggleterm.nvim",
        tag = "v2.*",
        config = require "plugins.configs.toggleterm"
    }
    use {
        "wellle/targets.vim"
    }
    use {
        -- Automatically highlighting other uses of the current word under the cursor
        "RRethy/vim-illuminate"
    }
    --[[ use {
        -- Automatic session management
        "rmagatti/auto-session",
    } ]]
    use {
        --  Aims to provide a simple, unified, single tabpage interface that lets you easily review all changed files for any git rev
        "sindrets/diffview.nvim",
        requires = "nvim-lua/plenary.nvim"
    }
    use {
        -- Project management
        "ahmedkhalf/project.nvim",
        requires = "nvim-telescope/telescope.nvim",
        config = require "plugins.configs.project"
    }
    ---- Comments
    use {
        "numToStr/Comment.nvim",
        config = require "plugins.configs.comment",
    }

    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = require "plugins.configs.todo"
    }
    use {
        "williamboman/mason.nvim",
        config = require "plugins.configs.mason"
    }

    ---- LSP
    use {
        "neovim/nvim-lspconfig",
        config = require "plugins.configs.lspconfig"
    }
    use {
        "simrat39/rust-tools.nvim",
        requires = "nvim-lua/plenary.nvim"
    }
    use "mfussenegger/nvim-jdtls"

    -- Debug
    use "mfussenegger/nvim-dap"
    use {
        "rcarriga/nvim-dap-ui",
        config = require "plugins.configs.dapui"
    }

    use {
        "nvim-telescope/telescope-dap.nvim",
        requires = { "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap" },
        config = require "plugins.configs.telescopedap"
    }

    use {
        "ggandor/leap.nvim",
        config = require "plugins.configs.leap"
    }

   ---- Snippets
    use {
        "L3MON4D3/LuaSnip",
    }
    use {
        "rafamadriz/friendly-snippets",
    }
    ---- Completion
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "lukas-reineke/cmp-under-comparator", -- Better sort completion items starting with underscore (Python)
        },
        config = require "plugins.configs.cmp"
    }
    -- VSCode like item type icons
    use "onsails/lspkind.nvim"

    use "ray-x/lsp_signature.nvim"

    -- Tmux
    use {
        "aserowy/tmux.nvim",
        config = require "plugins.configs.tmux"
    }

    ---- Git
    use {
        -- Add git related info in the signs columns and popups
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = require "plugins.configs.gitsigns"
    }
end)
