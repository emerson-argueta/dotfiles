return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.5',
	dependencies = { { 'nvim-lua/plenary.nvim' }, { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } },
	config = function()
		local telescope = require('telescope')

		telescope.setup {
			pickers = {
				find_files = { hidden = true }
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
				}
			}
		}

		telescope.load_extension('fzf')
	end
}
