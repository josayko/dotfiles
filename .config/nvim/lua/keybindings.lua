local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", {noremap = true, silent = true})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Ctrl+S to save
keymap("n", "<c-s>", ":w<cr>", {})
keymap("i", "<c-s>", "<Esc>:w<cr>a", {})

-- Panes navigaton
local opts = {noremap = true}
local function nkeymap(key, map)
  keymap("n", key, map, opts)
end
nkeymap("<c-j>", "<c-w>j")
nkeymap("<c-h>", "<c-w>h")
nkeymap("<c-k>", "<c-w>k")
nkeymap("<c-l>", "<c-w>l")

-- Code formatter
keymap("n", "<leader>f", ":lua vim.lsp.buf.format()<cr>", {noremap = true, silent = true})

-- Disable highlight search
keymap("n", "<cr>", ":nohlsearch<cr>", {noremap = true, silent = true})

-- Lsp
nkeymap("gd", ":lua vim.lsp.buf.definition()<cr>")
nkeymap("gD", ":lua vim.lsp.buf.declaration()<cr>")
nkeymap("gi", ":lua vim.lsp.buf.implementation()<cr>")
nkeymap("gw", ":lua vim.lsp.buf.document_symbol()<cr>")
nkeymap("gw", ":lua vim.lsp.buf.workspace_symbol()<cr>")
nkeymap("gr", ":lua vim.lsp.buf.references()<cr>")
nkeymap("gt", ":lua vim.lsp.buf.type_definition()<cr>")
nkeymap("K", ":lua vim.lsp.buf.hover()<cr>")
nkeymap("<c-k>", ":lua vim.lsp.buf.signature_help()<cr>")
nkeymap("<leader>af", ":lua vim.lsp.buf.code_action()<cr>")
nkeymap("<leader>rn", ":lua vim.lsp.buf.rename()<cr>")
nkeymap("<leader>e", ":lua vim.diagnostic.open_float(0)<cr>")

-- Telescope
nkeymap("<leader>ff", ":lua require('telescope.builtin').find_files()<cr>")
nkeymap("<leader>fg", ":lua require('telescope.builtin').live_grep()<cr>")
nkeymap("<leader>fb", ":lua require('telescope.builtin').buffers()<cr>")
nkeymap("<leader>fh", ":lua require('telescope.builtin').help_tags()<cr>")

-- nvim tree
nkeymap("<c-n>", ":NvimTreeToggle<cr>")
nkeymap("<leader>r", ":NvimTreeRefresh<cr>")
nkeymap("<leader>n", ":NvimTreeFindFile<cr>")
