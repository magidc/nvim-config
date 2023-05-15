local ok_dap, dap = pcall(require, "dap")
local ok_dapui, dapui = pcall(require, "dapui")

if not ok_dapui or not ok_dap then
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
        max_height = nil,  -- These can be integers or a float between 0 and 1.
        max_width = nil,   -- Floats will be treated as percentage of your screen.
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

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end


 -- codelldb
-- dap.adapters.codelldb = {
--     type = "server",
--     port = "${port}",
--     executable = {
--         command = "/usr/bin/codelldb",
--         args = { "--port", "${port}" },
--     },
-- }
-- -- Rust
-- dap.configurations.rust = {
--     {
--         type = "codelldb",
--         request = "launch",
--         -- This is where cargo outputs the executable
--         program = function ()
--             os.execute("cargo build &> /dev/null")
--             return "target/debug/${workspaceFolderBasename}"
--         end,
--         args = function ()
--             local argv = {}
--             arg = vim.fn.input(string.format("argv: "))
--             for a in string.gmatch(arg, "%S+") do
--                 table.insert(argv, a)
--             end
--             return argv
--         end,
--         cwd = "${workspaceFolder}",
--         -- Uncomment if you want to stop at main
--         -- stopOnEntry = true,
--         MIMode = "gdb",
--         miDebuggerPath = "/usr/bin/gdb",
--         setupCommands = {
--             {
--                 text = "-enable-pretty-printing",
--                 description = "enable pretty printing",
--                 ignoreFailures = false,
--             },
--         },
--     },
-- }
--
--
