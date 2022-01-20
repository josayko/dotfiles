-- Packer plugins manager
-- Use `:PackerSync` to install/update
-- Use `:PackerClean` to delete unused
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require("packer").startup(
  function()
    use "wbthomason/packer.nvim"
    use "neovim/nvim-lspconfig"
    use 'joshdick/onedark.vim' -- Theme inspired by Atom
    use "mhartington/formatter.nvim"
    use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client

    use '/windwp/nvim-autopairs'
    use 'ludovicchabant/vim-gutentags' -- Automatic tags management
    use 'itchyny/lightline.vim' -- Fancier statusline

    -- Autocompletion plugins
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- Add indentation guides even on blank lines
    use 'lukas-reineke/indent-blankline.nvim'
  end
)
