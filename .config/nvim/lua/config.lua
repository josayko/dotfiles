-- General
vim.o.number = true
vim.o.relativenumber = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.cursorline = true
vim.o.linebreak = true -- Stop words being broken on wrap
vim.o.hidden = true -- Enable background buffers
vim.o.ignorecase = true -- Ignore case
vim.o.incsearch = true -- Shows the match while typing
vim.o.hlsearch = true -- Highlight found searches
vim.o.pumblend = 30 -- pseudo-transparency of popup-menu
vim.cmd [[set mouse=a]]

--Decrease update time
vim.o.updatetime = 50
vim.wo.signcolumn = "yes"

-- Color scheme
vim.opt.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.cmd [[colorscheme onedark]]

--Set statusbar
vim.g.lightline = {
  colorscheme = "onedark",
  active = {left = {{"mode", "paste"}, {"gitbranch", "readonly", "filename", "modified"}}},
  component_function = {gitbranch = "fugitive#head"}
}

-- Formatter
local function format_prettier()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--single-quote"},
    stdin = true
  }
end

require("formatter").setup(
  {
    logging = true,
    filetype = {
      c = {
        -- clang-format
        function()
          return {
            exe = "clang-format",
            args = {"-style=Webkit --assume-filename", vim.api.nvim_buf_get_name(0)},
            stdin = true,
            cwd = vim.fn.expand("%:p:h") -- Run clang-format in cwd of the file.
          }
        end
      },
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
      javascript = {format_prettier},
      typescript = {format_prettier},
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
      python = {
        -- Configuration for psf/black
        function()
          return {
            exe = "black", -- this should be available on your $PATH
            args = {"-"},
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
  autocmd BufWritePost *c,*.cpp,*.js,*ts,*.rs,*.py FormatWrite
  autocmd FileType c setlocal shiftwidth=4 tabstop=4 noexpandtab
  autocmd FileType cpp,go,python,rust setlocal shiftwidth=4 tabstop=4
augroup END
]],
  true
)
