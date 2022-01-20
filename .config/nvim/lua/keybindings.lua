local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", {noremap = true, silent = true})
vim.g.mapleader = " "
vim.g.maplocalleader = " "


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

-- Disable highlight search
keymap("n", "<CR>", ":nohlsearch<CR>", {noremap = true, silent = true})

-- Lsp
local function nkeymap(key, map)
  keymap('n', key, map, opts)
end

nkeymap('gd', ':lua vim.lsp.buf.definition()<cr>')
nkeymap('gD', ':lua vim.lsp.buf.declaration()<cr>')
nkeymap('gi', ':lua vim.lsp.buf.implementation()<cr>')
nkeymap('gw', ':lua vim.lsp.buf.document_symbol()<cr>')
nkeymap('gw', ':lua vim.lsp.buf.workspace_symbol()<cr>')
nkeymap('gr', ':lua vim.lsp.buf.references()<cr>')
nkeymap('gt', ':lua vim.lsp.buf.type_definition()<cr>')
nkeymap('K', ':lua vim.lsp.buf.hover()<cr>')
nkeymap('<c-k>', ':lua vim.lsp.buf.signature_help()<cr>')
nkeymap('<leader>af', ':lua vim.lsp.buf.code_action()<cr>')
nkeymap('<leader>rn', ':lua vim.lsp.buf.rename()<cr>')

-- Using Lua functions
keymap('n', '<leader>ff', ":lua require('telescope.builtin').find_files()<cr>", {noremap = true})

keymap('n', '<leader>fg', ":lua require('telescope.builtin').live_grep()<cr>", {noremap = true})
keymap('n', '<leader>fb', ":lua require('telescope.builtin').buffers()<cr>", {noremap = true})
keymap('n', '<leader>fh', ":lua require('telescope.builtin').help_tags()<cr>", {noremap = true})
