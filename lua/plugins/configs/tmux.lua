local ok, tmux = pcall(require, "tmux")

if not ok then
    return
end

tmux.setup {
    copy_sync = {
        enable = false,
    },
    navigation = {
        enable_default_keybindings = true,
    },
    resize = {
        enable_default_keybindings = false,
    },
}
