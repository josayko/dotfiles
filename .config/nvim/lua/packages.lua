-- Packer plugins manager
-- Use `:PackerSync` to install/update
-- Use `:PackerClean` to delete unused
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  Packer_bootstrap =
  fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end

require("packer").startup(function(use)
  use("wbthomason/packer.nvim")
  use("rmehri01/onenord.nvim")
  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("null-ls").setup()
    end,
    requires = { "nvim-lua/plenary.nvim" },
  })
  use({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  })
  use("ludovicchabant/vim-gutentags") -- Automatic tags management
  use({
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({})
    end,
  })

  -- Autocompletion plugins
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp-signature-help")
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("ntpeters/vim-better-whitespace")
  use({ "echasnovski/mini.completion", branch = "stable" })

  -- Startup page
  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
      local startify = require("alpha.themes.startify")
      startify.section.bottom_buttons.val = {
        startify.button("v", "neovim config", ":e ~/.config/nvim/init.lua <cr>"),
        startify.button("q", "quit nvim", ":qa <cr>"),
      }
      vim.api.nvim_set_keymap("n", "<leader>m", ":Alpha <cr>", { noremap = true })
    end,
  })

  -- IDE
  use("lukas-reineke/indent-blankline.nvim") -- Indentation lines
  use("windwp/nvim-autopairs") -- Autopairs
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
  })
  use({
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons", -- optional, for file icon
    },
    config = function()
      require("nvim-tree").setup({})
    end,
  })
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })
  use("norcalli/nvim-colorizer.lua")
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({})
    end,
  })
  use({
    "lewis6991/gitsigns.nvim",
    -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
  })
  use({
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
  })
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })

  if packer_bootstrap then
    require("packer").sync()
  end
end)
