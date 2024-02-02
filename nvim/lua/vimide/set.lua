vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.api.nvim_create_autocmd({"BufLeave", "FocusLost"}, {
    pattern = "*",
    command = "if &modifiable | silent! w | endif"
})

