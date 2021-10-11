-- Include config files in ~/.config/nvim/lua/
require("config")
require("keybindings")
require("packages")

-- Lsp
require("lspconfig").clangd.setup({})

-- Formatter
require("formatter").setup(
  {
    filetype = {
      cpp = {
        -- clang-format
        function()
          return {
            exe = "clang-format",
            args = {"--assume-filename", vim.api.nvim_buf_get_name(0)},
            stdin = true,
            cwd = vim.fn.expand("%:p:h") -- Run clang-format in cwd of the file.
          }
        end
      },
      javascript = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--single-quote"},
            stdin = true
          }
        end
      },
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      },
      rust = {
        -- Rustfmt
        function()
          return {
            exe = "rustfmt",
            args = {"--emit=stdout"},
            stdin = true
          }
        end
      }
    }
  }
)

-- Autocmd
-- Format on save
vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.cpp,*.js,*.lua FormatWrite
augroup END
]],
  true
)
