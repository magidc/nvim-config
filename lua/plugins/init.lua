local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system {"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path}
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
    use "rmehri01/onenord.nvim"
    use "folke/tokyonight.nvim"
    use "navarasu/onedark.nvim"
    use "bluz71/vim-moonfly-colors"
    use {
        "marko-cerovac/material.nvim",
        config = require "plugins.configs.materialui"
    }
    ---- UI
    use "mhinz/vim-startify" -- Start page
    
    use "kyazdani42/nvim-web-devicons"
    use {
        "akinsho/bufferline.nvim",
        requires = {"kyazdani42/nvim-web-devicons"},
        config = require "plugins.configs.bufferline"
    }
    -- ALT: use {"romgrk/barbar.nvim", requires = {"kyazdani42/nvim-web-devicons"}} -- Fancy tabs
    use "folke/which-key.nvim"
    use {
        -- Smoother scroll
        "karb94/neoscroll.nvim",
        config = require "plugins.configs.neoscroll"
    }
    use {
        -- Scroll bar
        "petertriho/nvim-scrollbar",
        config = require "plugins.configs.scrollbar"
    }
    use {
        -- Status bar
        "nvim-lualine/lualine.nvim",
        config = require "plugins.configs.lualine"
    }   
    use {
        -- Status line component that shows context of the current cursor position in file.
        "SmiteshP/nvim-gps",
        requires = "nvim-treesitter/nvim-treesitter",
        config = require "plugins.configs.gps"
    }
    use {
        -- Loading animation (Just for nvim-lsp)
        "j-hui/fidget.nvim",
        config = require "plugins.configs.fidget"
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
    use "rcarriga/nvim-notify"
    use {
        -- Tree file explorer
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {"nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim"},
        config = require "plugins.configs.neotree"
    }
    use {
        -- Code outline window for skimming and quick navigation
        "stevearc/aerial.nvim",
        config = require "plugins.configs.aerial"
    }
    use {
        -- Search engine
        "nvim-telescope/telescope.nvim",
        requires = {"nvim-lua/plenary.nvim"},
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
        "tpope/vim-surround",
    }
    use {
        -- Colorize written color codes (#02F1AA, rgb(0,10,20)...)
        "norcalli/nvim-colorizer.lua",
        config = require "plugins.configs.colorizer"
    }
    use {
        -- Pretty list for showing diagnostics, references, telescope results, quickfix and location lists
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = require "plugins.configs.trouble"
    }
    use {
        "AckslD/nvim-neoclip.lua",
        requires = {"nvim-telescope/telescope.nvim"},
        config = require "plugins.configs.neoclip"
    }
    use {
        --- Improved terminal toggle
        "akinsho/toggleterm.nvim",
        tag = "v1.*",
        config = require "plugins.configs.toggleterm"
    }
    use "RRethy/vim-illuminate" -- Automatically highlighting other uses of the current word under the cursor
    use {
        -- Automatic session management
        'rmagatti/auto-session',
        config = require "plugins.configs.autosession"
    }
    use {
        --  Aims to provide a simple, unified, single tabpage interface that lets you easily review all changed files for any git rev
        "sindrets/diffview.nvim", 
        requires = "nvim-lua/plenary.nvim"
     }

     ---- Comment
     use {
        "numToStr/Comment.nvim",
        config = require "plugins.configs.comment",
    }   

    ---- LSP
    use "williamboman/nvim-lsp-installer"
   --[[  use {
        "neovim/nvim-lspconfig",
        config = require "plugins.configs.lspconfig"
    } ]]
    use "magidc/nvim-jdtls"

    -- Debug
    use "mfussenegger/nvim-dap"
    use {
      "rcarriga/nvim-dap-ui",
      config = require "plugins.configs.dapui"
    }
   
    use {
      "nvim-telescope/telescope-dap.nvim",
      config = function()
        require("telescope").load_extension("dap")
      end,
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
        requires = {"nvim-lua/plenary.nvim"},
        config = require "plugins.configs.gitsigns"
    }
end)
