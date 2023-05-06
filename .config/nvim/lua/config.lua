-- General

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.cursorline = true
vim.opt.linebreak = true -- Stop words being broken on wrap
vim.opt.hidden = true -- Enable background buffers
vim.opt.ignorecase = true -- Ignore case
vim.opt.incsearch = true -- Shows the match while typing
vim.opt.hlsearch = true -- Highlight found searches
vim.opt.pumblend = 15 -- pseudo-transparency of popup-menu
vim.opt.swapfile = false
vim.cmd([[set mouse=a]])
vim.api.nvim_command("set clipboard+=unnamedplus")

-- Decrease update time
vim.opt.updatetime = 50
vim.opt.signcolumn = "yes"

-- Color scheme
vim.opt.termguicolors = true
require("onenord").setup()

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
    null_ls.builtins.completion.tags,
  },
})

-------------------- Diagnostic messages --------------------------------------

vim.diagnostic.config({ virtual_text = true })

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local function setup_diags()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
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

