-- Keybindings
local keymap = vim.api.nvim_set_keymap

-- Ctrl+S to save
keymap("n", "<c-s>", ":w<CR>", {})
keymap("i", "<c-s>", "<Esc>:w<CR>a", {})

-- Panes navigaton
local opts = {noremap = true}
keymap("n", "<c-j>", "<c-w>j", opts)
keymap("n", "<c-h>", "<c-w>h", opts)
keymap("n", "<c-k>", "<c-w>k", opts)
keymap("n", "<c-l>", "<c-w>l", opts)

-- Code formatter
keymap("n", "<leader>f", ":Format<CR>", {noremap = true, silent = true})

keymap("n", "<CR>", ":nohlsearch<CR>", {noremap = true, silent = true})
