local telescope = require('telescope')

telescope.setup {
	pickers = {
		find_files = { hidden = true }
	},
	extensions = {
	    fzf = {
	      fuzzy = true,                    -- false will only do exact matching
	      override_generic_sorter = true,  -- override the generic sorter
	      override_file_sorter = true,     -- override the file sorter
    	}
  }
}

telescope.load_extension('fzf')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>fgs', builtin.git_status, { desc = '' })

