local ok, saga = pcall(require, "lspsaga")

if not ok then
    return
end

saga.setup(
    {
        code_action_lightbulb = {
            enable = false,
            sign = true,
            enable_in_insert = true,
            sign_priority = 20,
            virtual_text = true,
        },
        symbol_in_winbar = {
            enable = false,
        },
    })
