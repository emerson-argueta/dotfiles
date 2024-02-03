return {
	{ "tpope/vim-fugitive" },
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require('gitsigns').setup {
				signs = {
					add = { text = '+' },
					change = { text = '~' },
					delete = { text = '_' },
					topdelete = { text = '‾' },
					changedelete = { text = '~' },
				},
				current_line_blame = false,
				on_attach = function(bufnr)
					require('user.keymaps').git_keymaps(bufnr)
				end
			}
		end
	},
}
