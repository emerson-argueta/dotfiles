-- Map Oil to <leader>fe
local function oil_toggle_float()
	require("oil").toggle_float()
end
_G.oil_toggle_float = oil_toggle_float
local map = vim.api.nvim_set_keymap
map('n',"<leader>pv", ':lua oil_toggle_float() <CR>', { noremap = true, silent = true })
