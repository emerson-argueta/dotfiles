vim.keymap.set('v', '<leader>y', '"+y', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>sa', 'ggVG', { noremap = true, silent = true })
vim.keymap.set('c', '<Up>', '<C-p>', { noremap = true })
vim.keymap.set('c', '<Down>', '<C-n>', { noremap = true })
vim.keymap.set('n', '<C-b>', ':b#<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>c', ':bd<CR>', { noremap = true, silent = true })

-- Keymaps comments Ctrl-/ to toggle comments
vim.keymap.set('n', '<C-_>', ':Commentary<CR>', { noremap = true, silent = true })
vim.keymap.set('v', '<C-_>', ':Commentary<CR>', { noremap = true, silent = true })

-- Keymaps for folds
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

local M = {}
-- LSP keymaps (exports a function to be used in ../../plugins/lsp.lua b/c we need a reference to the current buffer) --
M.lsp_keymaps = function(bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	local opts = { buffer = bufnr, remap = false }
	local x_ops = function(additional_opts)
		return vim.tbl_extend("force", opts, additional_opts or {})
	end
	vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end,
		x_ops({ desc = "LSP: [R]ename" }))
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end,
		x_ops({ desc = "LSP: [V]iew [C]ode [A]ctions" }))
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end,
		x_ops({ desc = "LSP: [G]oto [D]efinition" }))
	vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references,
		x_ops({ desc = "LSP: [G]oto [R]eferences" }))
	vim.keymap.set("n", "gi", require('telescope.builtin').lsp_implementations,
		x_ops({ desc = "LSP: [G]oto [I]mplementation" }))
	vim.keymap.set("n", "<leader>bs", require('telescope.builtin').lsp_document_symbols,
		x_ops({ desc = "LSP: [B]uffer [S]ymbols" }))
	vim.keymap.set("n", "<leader>ps", require('telescope.builtin').lsp_workspace_symbols,
		x_ops({ desc = "LSP: [P]roject [S]ymbols" }))
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end,
		x_ops({ desc = "LSP: Hover Documentation" }))
	vim.keymap.set("n", "<leader>k", function() vim.lsp.buf.signature_help() end,
		x_ops({ desc = "LSP: Signature Documentation" }))
	vim.keymap.set("i", "<C-k>", function() vim.lsp.buf.signature_help() end,
		x_ops({ desc = "LSP: Signature Documentation" }))
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
end
vim.keymap.set('n', '<leader>af', ':LspZeroFormat<CR>', { noremap = true, silent = true })

-- Git keymaps (exports a function to be used in ../../plugins/git.lua b/c we need a reference to the current buffer) --
M.git_keymaps = function(bufnr)
	local opts = { buffer = bufnr }
	local x_ops = function(additional_opts)
		return vim.tbl_extend("force", opts, additional_opts or {})
	end
	local gs = package.loaded.gitsigns

	-- Navigation
	vim.keymap.set('n', ']c', function()
		if vim.wo.diff then return ']c' end
		vim.schedule(function() gs.next_hunk() end)
		return '<Ignore>'
	end, x_ops({ expr = true }))

	vim.keymap.set('n', '[c', function()
		if vim.wo.diff then return '[c' end
		vim.schedule(function() gs.prev_hunk() end)
		return '<Ignore>'
	end, x_ops({ expr = true }))
	-- Actions
	vim.keymap.set({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', opts)
	vim.keymap.set({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', opts)
	vim.keymap.set('n', '<leader>hS', gs.stage_buffer, opts)
	vim.keymap.set('n', '<leader>ha', gs.stage_hunk, opts)
	vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, opts)
	vim.keymap.set('n', '<leader>hR', gs.reset_buffer, opts)
	vim.keymap.set('n', '<leader>hp', gs.preview_hunk, opts)
	vim.keymap.set('n', '<leader>hb', function() gs.blame_line { full = true } end, opts)
	vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame, opts)
	vim.keymap.set('n', '<leader>hd', gs.diffthis, opts)
	vim.keymap.set('n', '<leader>hD', function() gs.diffthis('~') end, opts)
	vim.keymap.set('n', '<leader>td', gs.toggle_deleted, opts)
	-- Text object
	vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', opts)
end
-- set up a commit and push special command
local function commit_and_push()
	-- Prompt for commit message using Vim's built-in input function
	local commit_message = vim.fn.input('Commit Message: ')
	-- Check if the commit message is not empty
	if commit_message ~= "" then
		-- Run :G commit and :G push with the provided message
		vim.cmd("G commit -m '" .. commit_message .. "'")
		vim.cmd("G push")
	else
		print("Commit aborted: No commit message provided.")
	end
end
_G.commit_and_push = commit_and_push
vim.keymap.set('n', '<leader>gp', ':lua commit_and_push()<CR>', { noremap = true, silent = true })
-- remap :G to alt-g:
vim.keymap.set('n', '<leader>gg', ':G<CR>', { noremap = true, silent = true })

-- File explorer keymaps
local function oil_toggle_float()
	require("oil").toggle_float()
end
_G.oil_toggle_float = oil_toggle_float
vim.keymap.set('n', "<leader>fe", ':lua oil_toggle_float()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', "<leader>pv", ':Oil <CR>', { noremap = true, silent = true })
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

-- Debugging keymaps
vim.keymap.set('n', '<leader>dt', '<cmd>lua require("dapui").toggle()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>dc', '<cmd>lua require"dap".continue()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>b', '<cmd>lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>i', '<cmd>lua require"dap".step_into()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>n', '<cmd>lua require"dap".step_over()<CR>', { noremap = true, silent = true })


-- Ruby on Rails keymaps
-- This "list_commands()" will show a list of all the available commands to run
vim.keymap.set("n", "<Leader>fr", ":lua require('ror.commands').list_commands()<CR>", { silent = true })
-- Function to insert ERB tags
local function insert_erb_tag(tag_type)
    local tag = ""
    if tag_type == "output" then
        tag = "<%=  %>"
    elseif tag_type == "execution" then
        tag = "<%  %>"
    elseif tag_type == "execution_trim" then
        tag = "<%-  %>"
    end
    vim.api.nvim_put({tag}, 'c', true, true)
    -- Move cursor inside the brackets
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Left><Left><Left>', true, false, true), 'n', true)
end
-- Make the function globally accessible
_G.insert_erb_tag = insert_erb_tag
-- Map the function to different keybindings
vim.keymap.set('n', '<leader><', ':lua insert_erb_tag("output")<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>>', ':lua insert_erb_tag("execution")<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>,', ':lua insert_erb_tag("execution_trim")<CR>', { noremap = true, silent = true })


return M
