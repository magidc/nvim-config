local ok, rust = pcall(require, "rust-tools")

if not ok then
    return
end

rust.setup()

