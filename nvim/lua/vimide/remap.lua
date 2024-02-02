vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>sa', 'ggVG', {noremap = true, silent = true})
vim.api.nvim_set_keymap('c', '<Up>', '<C-p>', { noremap = true })
vim.api.nvim_set_keymap('c', '<Down>', '<C-n>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-b>', ':b#<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>c', ':bd<CR>', { noremap = true, silent = true })

