-- Global
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

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

--Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", {noremap = true, silent = true})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Color theme
vim.opt.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.cmd [[colorscheme onedark]]
