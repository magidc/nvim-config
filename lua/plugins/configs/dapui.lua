local ok, dapui = pcall(require, "dapui")

if not ok then
    return
end

dapui.setup {
    icons = {
        expanded = "▾",
        collapsed = "▸"
    },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r"
    },
    layouts = { {
        elements = { -- Elements can be strings or table with id and size keys.
            {
                id = "scopes",
                size = 0.25
            }, "breakpoints", "stacks", "watches" },
        size = 40,
        position = "left"
    }, {
        elements = { "repl", "console" },
        size = 10,
        position = "bottom"
    } },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" }
        }
    },
    windows = {
        indent = 1
    },
    controls = {
        enabled = true,
        -- Display controls in this element
        element = "repl",
        icons = {
            pause = "⏸︎",
            play = "⏵︎",
            step_into = "↓",
            step_over = "⤼",
            step_out = "↑",
            step_back = "←",
            run_last = "↻",
            terminate = "⏹︎",
        },
    }
}
