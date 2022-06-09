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

    ---- UI
    use "mhinz/vim-startify" -- Start page
    use "rmehri01/onenord.nvim" -- UI Theme
    use "kyazdani42/nvim-web-devicons"
    use {
        "akinsho/bufferline.nvim",
        requires = {"kyazdani42/nvim-web-devicons"},
        config = require "plugins.configs.bufferline"
    }
    -- ALT: use {"romgrk/barbar.nvim", requires = {"kyazdani42/nvim-web-devicons"}} -- Fancy tabs
    use "folke/which-key.nvim"
    use {
        "karb94/neoscroll.nvim",
        config = require "plugins.configs.neoscroll"
    }
    use {
        "nvim-lualine/lualine.nvim",
        config = require "plugins.configs.lualine"
    }   
    use {
        -- Status line component that shows context of the current cursor position in file.
        "SmiteshP/nvim-gps",
        requires = "nvim-treesitter/nvim-treesitter",
        config = require "plugins.configs.gps"
    }

    ---- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        requires = {
            --"windwp/nvim-ts-autotag", -- HTML nodes autoclose/rename
            "ludovicchabant/vim-gutentags", -- Automatic tags management
            "p00f/nvim-ts-rainbow", -- Open/Close node coloring
            "nvim-treesitter/nvim-treesitter-textobjects"},
        run = ":TSUpdate",
        config = require "plugins.configs.treesitter"
    }

    ---- Utilities
    --use "ludovicchabant/vim-gutentags" -- CTags auto updater (in files)
    use "majutsushi/tagbar" -- Tag explorer and tag updater (just memory)
 
    use {
        -- Tree file explorer
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {"nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim"},
        config = require "plugins.configs.neotree"
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
        setup = function()
            require("utils").packer_lazy_load "vim-surround"
        end
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
        -- Loading animation (Just for nvim-lsp)
        "j-hui/fidget.nvim",
        config = require "plugins.configs.fidget"
    }

     ---- Comment
     use {
        "numToStr/Comment.nvim",
        config = function()
            require "plugins.configs.comment"
        end,
        setup = function()
            require("utils").packer_lazy_load "Comment.nvim"
        end,
    }

    ---- LSP
    use "williamboman/nvim-lsp-installer"
   --[[  use {
        "neovim/nvim-lspconfig",
        config = require "plugins.configs.lspconfig"
    } ]]
    use "mfussenegger/nvim-jdtls"

    -- Debug
    use("gfanto/fzf-lsp.nvim")
    use("mfussenegger/nvim-dap")
    use({
      "rcarriga/nvim-dap-ui",
      config = function()
        require("plugin.configs.dapui")
      end,
    })
   
    use({
      "nvim-telescope/telescope-dap.nvim",
      config = function()
        require("telescope").load_extension("dap")
      end,
    })

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
    
    use {
        "ray-x/lsp_signature.nvim",
        setup = function()
            require("utils").packer_lazy_load "lsp_signature.nvim"
        end,
        config = require "plugins.configs.lsp_signature"
    }

    ---- Snippets
    use {
        "rafamadriz/friendly-snippets",
        setup = function()
            require("utils").packer_lazy_load "friendly-snippets"
        end,
    }

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
