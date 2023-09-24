vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--
vim.keymap.set('n', '<leader>h', ':nohls<CR>')
vim.keymap.set('n', '<leader>c', '@:<CR>')

-- easier to switch between modes
vim.keymap.set('n', ';', ':')
-- make left(h) and right(-) in the same row: I'm using dvorak layout
vim.keymap.set('', '-', 'l')
vim.keymap.set('i', 'jkj', '<ESC>')

-- create & tranverse tabs
vim.keymap.set('n', '<Tab>', 'gt')
vim.keymap.set('n', '<S-Tab>', 'gT')
vim.keymap.set('n', '<leader><Tab>', ':tabnew<CR>')

-- navigate through windows

vim.keymap.set('n', '<leader>wh', '<C-w>h')
vim.keymap.set('n', '<leader>wt', '<C-w>j')
vim.keymap.set('n', '<leader>wn', '<C-w>k')
vim.keymap.set('n', '<leader>ws', '<C-w>l')
