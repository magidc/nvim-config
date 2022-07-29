local _impatient, impatient = pcall(require, "impatient")
if _impatient then
    impatient.enable_profile()
end

require "settings"
require "mappings"
require "plugins"
require "lsp"
require "autocmds"
require "commands"
