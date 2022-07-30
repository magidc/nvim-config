local ok, installer = pcall(require, "nvim-lsp-installer")

if not ok then
    return
end

LSP_ROOT_PATH = os.getenv("HOME") .. "/.local/share/nvim/lsp_servers"
-- LSP_ROOT_PATH = path.concat { vim.fn.stdpath "data", "lsp_servers" }

installer.setup ({
    install_root_dir = LSP_ROOT_PATH
})
