local _M = {}

_M.powerline = {
    circle = {
        left = "",
        right = "",
    },
    arrow = {
        left = "",
        right = "",
    },
    triangle = {
        left = "",
        right = "",
    },
    none = {
        left = "",
        right = "",
    },
}

_M.signs = { Error = "", Warn = "", Hint = "", Info = "" }

_M.set_indent_sizes = function(filetypes)
    for filetype, size in pairs(filetypes) do
        vim.api.nvim_create_autocmd("FileType", {
            pattern = filetype,
            callback = function()
                vim.opt.shiftwidth = size
                vim.opt.tabstop = size
                vim.opt.softtabstop = size
            end,
        })
    end
end

_M.buf_command = function(bufnr, name, fn, opts)
    vim.api.nvim_buf_create_user_command(bufnr, name, fn, opts or {})
end

_M.table = {
    some = function(tbl, cb)
        for k, v in pairs(tbl) do
            if cb(k, v) then
                return true
            end
        end
        return false
    end,
}

return _M
