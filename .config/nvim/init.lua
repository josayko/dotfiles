-- Include config files in ~/.config/nvim/lua/
require("packages")
if (vim.loop.os_uname().sysname == "Linux") then
  require("config")
end
require("keybindings")
