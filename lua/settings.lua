local utils = require "utils"

local options = {
    termguicolors = true,
    fileencoding = "utf-8",
    autoread = true,
    wrap = true,
    backup = false,
    swapfile = false,
    hlsearch = true, -- Set highlight on search
    incsearch = true,
    showmode = false,
    expandtab = true,
    shiftwidth = 2,
    tabstop = 2,
    softtabstop = 2,
    scrolloff = 5,
    autoindent = true,
    smartindent = true,
    sidescrolloff = 5,
    signcolumn = "yes",
    hidden = true,
    ignorecase = true, -- Case insensitive searching UNLESS /C or capital in search
    timeoutlen = 1000,
    shiftround = true,
    smartcase = true,
    splitbelow = true,
    splitright = true,
    number = true, -- Make line numbers default
    relativenumber = true,
    clipboard = "unnamed,unnamedplus", -- Use system clipboard
    cursorline = true,
    mouse = "a", -- Enable mouse mode
    cmdheight = 1,
    undodir = "/tmp/.nvimdid",
    undofile = true, -- Save undo history
    pumheight = 10,
    laststatus = 3,
    updatetime = 250, -- Decrease update time
    background = "dark",
    completeopt = "menuone", -- Set completeopt to have a better completion experience
    breakindent = true, -- Enable break indent
    foldmethod = "expr",
    foldexpr = "nvim_treesitter#foldexpr()",
}

for key, value in pairs(options) do
    vim.opt[key] = value
end

vim.opt.shortmess:append "c"

vim.cmd [[set fcs=eob:\ ]]
vim.cmd [[filetype plugin indent on]]

-- Space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

utils.set_indent_sizes { go = 4, python = 4, rust = 4, cpp = 4, c = 4, make = 4, lua = 4 }

-- nvim-notify as default vim notification method
vim.notify = require("notify")

-- UI theme
require"theme".init"tokyonight"
