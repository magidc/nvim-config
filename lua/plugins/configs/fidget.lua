local ok, fidget = pcall(require, "fidget")

if not ok then
    return
end

fidget.setup {
    text = {
        spinner = "moon",
        done = "✔", 
        commenced = "Started",
        completed = "Completed"
    }
}
