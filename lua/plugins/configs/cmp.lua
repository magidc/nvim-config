local _cmp, cmp = pcall(require, "cmp")
local _luasnip, luasnip = pcall(require, "luasnip")
local _lspkind, lspkind = pcall(require, "lspkind")

if not _cmp or not _lspkind or not _luasnip then
    return
end

-- Lazy load all vscode like snippets
require("luasnip/loaders/from_vscode").lazy_load()

cmp.setup {
    preselect = cmp.PreselectMode.Item,
    -- completion = { autocomplete = false }, -- Make completion only on demand
    enabled = function()
        local in_prompt = vim.api.nvim_buf_get_option(0, "buftype") == "prompt"
        if in_prompt then
            return false
        end
        local context = require "cmp.config.context"
        return not (context.in_treesitter_capture "comment" == true or context.in_syntax_group "Comment")
    end,
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    sorting = {
        comparators = { cmp.config.compare.offset, cmp.config.compare.exact, cmp.config.compare.score,
            cmp.config.compare._under_comparator, cmp.config.compare.kind, cmp.config.compare.sort_text,
            cmp.config.compare.length, cmp.config.compare.order }
    },
    formatting = {
        format = function(entry, vim_item)
            -- Fancy icons and a name of kind
            vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
            return vim_item
        end
    },

    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-q>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({
            select = true
        }) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer" }
    },
}

cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = "buffer" } }
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } })
})
