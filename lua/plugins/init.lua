local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system {"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
                                      install_path}
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
        requires = {"windwp/nvim-ts-autotag", -- ALT:use "ludovicchabant/vim-gutentags" -- Automatic tags management
        "p00f/nvim-ts-rainbow", -- Open/Close node coloring
        "nvim-treesitter/nvim-treesitter-textobjects"},
        run = ":TSUpdate",
        config = require "plugins.configs.treesitter"
    }

    ---- Utilities
    use "majutsushi/tagbar" -- Tag explorer
    use {
        -- Tree file explorer
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {"nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim"},
        config = require "plugins.configs.neotree"
    }
    use {
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
        "akinsho/toggleterm.nvim",
        tag = "v1.*",
        config = require "plugins.configs.toggleterm"
    }

    ---- LSP
    use {
        "neovim/nvim-lspconfig",
        requires = {
            -- As reference "jose-elias-alvarez/typescript.nvim",
        }
    }
    use "ray-x/lsp_signature.nvim"

    ---- Comment
    use {
        "numToStr/Comment.nvim",
        config = require "plugins.configs.comment"
    }

    ---- Completion
    use {
        "hrsh7th/nvim-cmp",
        requires = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path",
                    "hrsh7th/cmp-cmdline", "hrsh7th/cmp-nvim-lsp-document-symbol", "hrsh7th/cmp-vsnip",
                    "hrsh7th/vim-vsnip"},
        config = require "plugins.configs.cmp"
    }

    ---- Snippets
    use "kitagry/vs-snippets"
    -- ALT: use "L3MON4D3/LuaSnip" -- Snippets plugin
    -- ALT: use "saadparwaiz1/cmp_luasnip"

    -- Tmux
    --[[ use {
        "aserowy/tmux.nvim",
        config = require "plugins.configs.tmux"
    } ]]

    ---- Git
    use {
        -- Add git related info in the signs columns and popups
        "lewis6991/gitsigns.nvim",
        requires = {"nvim-lua/plenary.nvim"},
        config = require "plugins.configs.gitsigns"
    }
end)
