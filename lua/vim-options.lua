vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.g.mapleader = " "
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = "Esc key to exit :term"})
