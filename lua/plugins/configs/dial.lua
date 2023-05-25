local ok, dial = pcall(require, "dial.config")

if not ok then
    return
end

local augend = require("dial.augend")
dial.augends:register_group {
    default = {
        augend.integer.alias.decimal_int,
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.semver.alias.semver,
        augend.constant.alias.bool,
        augend.date.alias["%d/%m/%y"],
        augend.date.alias["%d/%m/%Y"],
        augend.constant.new {
            elements = { "private", "protected", "public" },
            word = true, -- if false, terms are incremented even if they are contained withing other words
            cyclic = true,
        },
    }
}
