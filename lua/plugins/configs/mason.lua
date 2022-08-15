local ok, mason = pcall(require, "mason")

if not ok then
    return
end

-- INSTALL_ROOT_PATH = path.concat { vim.fn.stdpath "data", "mason" }
INSTALL_ROOT_PATH = os.getenv("HOME") .. "/.local/share/nvim/mason"
LSP_ROOT_PATH = INSTALL_ROOT_PATH .. "/packages"

mason.setup({
    install_root_dir = INSTALL_ROOT_PATH,
})
