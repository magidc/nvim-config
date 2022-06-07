local _cmp, cmp = pcall(require, "cmp")
local _vsnip, vsnip = pcall(require, "vsnip")
local _lspkind, lspkind = pcall(require, "lspkind")

if not _cmp or not _lspkind then
    return
end

if _vsnip then
    require("vsnip.loaders.from_vscode").lazy_load()
end

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end


cmp.setup {
    enabled = function()
        local in_prompt = vim.api.nvim_buf_get_option(0, "buftype") == "prompt"
        if in_prompt then
            return false
        end
        local context = require "cmp.config.context"
        return not (context.in_treesitter_capture "comment" == true or context.in_syntax_group "Comment")
    end,
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end
    },
    sorting = {
        comparators = {cmp.config.compare.offset, cmp.config.compare.exact, cmp.config.compare.score,
                       cmp.config.compare._under_comparator, cmp.config.compare.kind, cmp.config.compare.sort_text,
                       cmp.config.compare.length, cmp.config.compare.order}
    },
    formatting = {
        format = function(entry, vim_item)
            -- fancy icons and a name of kind
            vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
            -- set a name for each source
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                ultisnips = "[UltiSnips]",
                nvim_lua = "[Lua]",
                cmp_tabnine = "[TabNine]",
                look = "[Look]",
                path = "[Path]",
                spell = "[Spell]",
                calc = "[Calc]",
                emoji = "[Emoji]"
            })[entry.source.name]
            return vim_item
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({
            select = true
        }) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = {
        {name = "nvim_lsp"},
        {name = "nvim_lua"},
        {name = "vsnip"},
        {name = "path"},
        {name = "buffer"}
        },
    }

cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{name = "buffer"}}
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline"}})
})
