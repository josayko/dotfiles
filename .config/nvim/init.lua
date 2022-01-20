-- Include config files in ~/.config/nvim/lua/
require("packages")
require("config")
require("keybindings")

-- IDE-like Neovim config
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

-- Autopairs
require("nvim-autopairs").setup {}

-- Setup Lspconfig
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(
  function(server)
    local opts = {}
    if server.name == "sumneko_lua" then
      opts = {
        settings = {
          Lua = {
            diagnostics = {
              globals = {"vim", "use"}
            }
          }
        }
      }
    end
    server:setup(opts)
  end
)

-- Setup nvim-cmp.
local cmp = require("cmp")

local luasnip = require("luasnip")
cmp.setup(
  {
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      end
    },
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true
      },
      ["<Tab>"] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end,
      ["<S-Tab>"] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end
    },
    sources = cmp.config.sources(
      {
        {name = "nvim_lsp"},
        {name = "luasnip"}
      },
      {
        {name = "buffer"}
      }
    )
  }
)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  "/",
  {
    sources = {
      {name = "buffer"}
    }
  }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  ":",
  {
    sources = cmp.config.sources(
      {
        {name = "path"}
      },
      {
        {name = "cmdline"}
      }
    )
  }
)

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Treesitter - Folding lines
vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"

-- This is a cool function
local function blaho()
  print "hello world\n"
end

