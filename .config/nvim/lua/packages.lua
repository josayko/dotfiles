-- Packer plugins manager
-- Use `:PackerSync` to install/update
-- Use `:PackerClean` to delete unused
require("packer").startup(
  function()
    use "wbthomason/packer.nvim"
    use "navarasu/onedark.nvim"
    use "neovim/nvim-lspconfig"
    use "mhartington/formatter.nvim"
  end
)
