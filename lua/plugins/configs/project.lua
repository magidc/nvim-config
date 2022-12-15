local ok, project = pcall(require, "project_nvim")

if not ok then
    return
end

project.setup {
    -- No auto detection, managing file manually
    detection_methods = {},
}
require("telescope").load_extension("projects")

