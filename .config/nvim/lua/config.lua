-- General

vim.o.number = true
vim.o.relativenumber = false
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.cursorline = true
vim.o.linebreak = true -- Stop words being broken on wrap
vim.o.hidden = true -- Enable background buffers
vim.o.ignorecase = true -- Ignore case
vim.o.incsearch = true -- Shows the match while typing
vim.o.hlsearch = true -- Highlight found searches
vim.o.pumblend = 15 -- pseudo-transparency of popup-menu
vim.o.swapfile = false
vim.cmd([[set mouse=a]])
vim.api.nvim_command("set clipboard+=unnamedplus")

-- Decrease update time
vim.o.updatetime = 50
vim.wo.signcolumn = "yes"

-- Color scheme
vim.o.termguicolors = true
local colorscheme = require("onedark")

colorscheme.setup({
  transparent = false,
  transparent_sidebar = false,
})

--------------------------------- Formatter -----------------------------------

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.rubocop,
    null_ls.builtins.formatting.prettier,

    null_ls.builtins.diagnostics.rubocop,
    null_ls.builtins.diagnostics.tsc,
    null_ls.builtins.diagnostics.eslint,

    null_ls.builtins.completion.luasnip,
    null_ls.builtins.completion.spell,
    null_ls.builtins.completion.tags
  },
})

-------------------- Diagnostic messages --------------------------------------

vim.diagnostic.config({ virtual_text = false })

local function setup_diags()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = false,
    update_in_insert = false,
    underline = true,
  })
end

local function setup_qf()
  local pubdiag = "textDocument/publishDiagnostics"
  local def_pubdiag_handler = vim.lsp.handlers[pubdiag]
  vim.lsp.handlers[pubdiag] = function(err, method, res, cid, bufnr, cfg)
    def_pubdiag_handler(err, method, res, cid, bufnr, cfg)
    vim.diagnostic.setqflist({ open = false })
  end
end

setup_diags()
setup_qf()

-------------------------------------------------------------------------------

-- Autocmd
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
})

vim.api.nvim_exec(
  [[
augroup AutoFormatGroup
  autocmd!
  autocmd FileType c setlocal shiftwidth=4 tabstop=4 noexpandtab
  autocmd FileType cpp,go,python,rust setlocal shiftwidth=4 tabstop=4
  autocmd FileType js,ts,ruby setlocal shiftwidth=2 tabstop=2
augroup END
]] ,
  true
)
