local ok, telescope = pcall(require, "telescope")

if not ok then
    return
end

telescope.setup {
    picker = {
        hidden = false,
    },
    defaults = {
        file_ignore_patterns = { "/.git/","/.settings/", "/.metadata/", "/target/", "/node_modules/", '.class$' },
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false
            }
        }
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
}

telescope.load_extension "fzf"