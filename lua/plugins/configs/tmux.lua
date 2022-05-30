local ok, tmux = pcall(require, "tmux")

if not ok then
    return
end

tmux.setup {
    copy_sync = {
        enable = true,
    },
    navigation = {
        enable_default_keybindings = true,
    },
    resize = {
        enable_default_keybindings = true,
    },
}
