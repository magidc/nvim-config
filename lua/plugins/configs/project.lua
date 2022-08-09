local ok, project = pcall(require, "project_nvim")

if not ok then
    return
end

project.setup {
    -- Using maker file ".project" as a hacky way to detect project directory. Refusing to use ".git" as there are projects involving multiple git repos
    patterns = { "*.code-workspace", ".metadata", ".project.nvim", "Makefile", "package.json" },
}
