-- Include config files in ~/.config/nvim/lua/
require("packages")
require("config")
require("keybindings")

-- IDE-like Neovim config
require("nvim-treesitter.configs").setup({
  ensure_installed = "all", -- Only use parsers that are maintained
  highlight = {
    -- enable highlighting
    enable = true,
    disable = {},
  },
  indent = {
    enable = true, -- default is disabled anyways
  },
})

require("telescope").setup({
  pickers = {
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        },
      },
    },
    find_files = {
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
    },
    live_grep = {
      sort_lastused = true,
      theme = "dropdown",
    },
    help_tags = {
      sort_lastused = true,
      theme = "dropdown",
    },
  },
})

vim.opt.listchars = "eol:↵,trail:~,tab:>-,nbsp:␣"

-- Lualine statusbar
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "onenord",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      "diff",
      { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
    },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})

-- indent blankline
require("indent_blankline").setup({
  space_char_blankline = " ",
  show_current_context = false,
  show_current_context_start = false,
})

-- Autopairs
require("nvim-autopairs").setup({})

-- Colorizer
require("colorizer").setup({ "*" }, {
  RGB = true, -- #RGB hex codes
  RRGGBB = true, -- #RRGGBB hex codes
  names = true, -- "Name" codes like Blue
  RRGGBBAA = false, -- #RRGGBBAA hex codes
  rgb_fn = false, -- CSS rgb() and rgba() functions
  hsl_fn = true, -- CSS hsl() and hsla() functions
  css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
  css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
})

require("gitsigns").setup()
require("Comment").setup()

---------------------------------- Lspconfig ----------------------------------
require("mason").setup()
require("mason-lspconfig").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require("lspconfig")
lspconfig.ruby_ls.setup({})
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})
lspconfig.emmet_ls.setup({
  -- on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "css", "typescriptreact", "javascriptreact" },
})

lspconfig.elixirls.setup({
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  elixirLS = {
    dialyzerEnabled = false,
    fetchDeps = false,
  },
})

------------------------ Autocompletion: nvim-cmp -----------------------------
local cmp = require("cmp")

local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
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
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
})
-------------------------------------------------------------------------------

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

-- Set completeopt to have a better completion experience
vim.opt.completeopt = "menuone,noselect"

-- Treesitter - Folding lines
vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-------------------------------------------------------------------------------
