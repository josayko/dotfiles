-- Include config files in ~/.config/nvim/lua/
require("packages")
if (vim.loop.os_uname().sysname == "Linux") then
  require("config")
end
require("keybindings")

-- IDE
local configs = require "nvim-treesitter.configs"
configs.setup {
  ensure_installed = "maintained", -- Only use parsers that are maintained
  highlight = {
    -- enable highlighting
    enable = true
  },
  indent = {
    enable = true -- default is disabled anyways
  }
}

vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"

local function blah()
  print "hello world\n"
end
