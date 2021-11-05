-- Packer plugins manager
-- Use `:PackerSync` to install/update
-- Use `:PackerClean` to delete unused
require("packer").startup(
  function()
    use "wbthomason/packer.nvim"
    use "neovim/nvim-lspconfig"
    use 'joshdick/onedark.vim' -- Theme inspired by Atom
    use "mhartington/formatter.nvim"
    use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use '/windwp/nvim-autopairs'
    use 'ludovicchabant/vim-gutentags' -- Automatic tags management
    use 'itchyny/lightline.vim' -- Fancier statusline
    -- Add indentation guides even on blank lines
    use 'lukas-reineke/indent-blankline.nvim'
  end
)
