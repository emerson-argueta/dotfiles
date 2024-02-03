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

-- UFO setup
--vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
