local nnoremap = require("user.keymap_utils").nnoremap
local vnoremap = require("user.keymap_utils").vnoremap
local inoremap = require("user.keymap_utils").inoremap
local tnoremap = require("user.keymap_utils").tnoremap
local xnoremap = require("user.keymap_utils").xnoremap
local harpoon_ui = require("harpoon.ui")
local harpoon_mark = require("harpoon.mark")
local illuminate = require("illuminate")
local utils = require("user.utils")

local M = {}

local TERM = os.getenv("TERM")

-- Normal --
-- Disable Space bar since it'll be used as the leader key
nnoremap("<space>", "<nop>")
-- select all shortcut
vim.keymap.set('n', '<leader>sa', 'ggVG', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>y', '"+y', { noremap = true, silent = true })
-- navigate command optios with arrow keys
vim.keymap.set('c', '<Up>', '<C-p>', { noremap = true })
vim.keymap.set('c', '<Down>', '<C-n>', { noremap = true })
-- Keymaps comments Ctrl-/ to toggle comments
vim.keymap.set('n', '<C-_>', ':Commentary<CR>', { noremap = true, silent = true })
vim.keymap.set('v', '<C-_>', ':Commentary<CR>', { noremap = true, silent = true })
-- Swap between last two buffers
nnoremap("<leader>'", "<C-^>", { desc = "Switch to last buffer" })
nnoremap('<leader>c', ':bd<CR>')
-- Save with leader key
nnoremap("<leader>w", "<cmd>w<cr>", { silent = false })
-- Quit with leader key
nnoremap("<leader>q", "<cmd>q<cr>", { silent = false })
-- Map Oil to <leader>e
nnoremap("<leader>fe", function()
	require("oil").toggle_float()
end)
nnoremap("<leader>e", ':Oil <CR>')
-- Center buffer while navigating
nnoremap("<C-u>", "<C-u>zz")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("{", "{zz")
nnoremap("}", "}zz")
nnoremap("N", "Nzz")
nnoremap("n", "nzz")
nnoremap("G", "Gzz")
nnoremap("gg", "ggzz")
nnoremap("<C-i>", "<C-i>zz")
nnoremap("<C-o>", "<C-o>zz")
nnoremap("%", "%zz")
nnoremap("*", "*zz")
nnoremap("#", "#zz")
-- Press 'S' for quick find/replace for the word under the cursor
nnoremap("S", function()
	local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
	local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end)
-- Open Spectre for global find/replace
nnoremap("<leader>S", function()
	require("spectre").toggle()
end)
-- Open Spectre for global find/replace for the word under the cursor in normal mode
-- TODO Fix, currently being overriden by Telescope
nnoremap("<leader>sw", function()
	require("spectre").open_visual({ select_word = true })
end, { desc = "Search current word" })
-- Press 'H', 'L' to jump to start/end of a line (first/last char)
nnoremap("L", "$")
nnoremap("H", "^")
-- Press 'U' for redo
nnoremap("U", "<C-r>")
-- Turn off highlighted results
nnoremap("<leader>no", "<cmd>noh<cr>")
-- Diagnostics
-- Goto next diagnostic of any severity
nnoremap("]d", function()
	vim.diagnostic.goto_next({})
	vim.api.nvim_feedkeys("zz", "n", false)
end)
-- Goto previous diagnostic of any severity
nnoremap("[d", function()
	vim.diagnostic.goto_prev({})
	vim.api.nvim_feedkeys("zz", "n", false)
end)
-- Goto next error diagnostic
nnoremap("]e", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	vim.api.nvim_feedkeys("zz", "n", false)
end)
-- Goto previous error diagnostic
nnoremap("[e", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	vim.api.nvim_feedkeys("zz", "n", false)
end)
-- Goto next warning diagnostic
nnoremap("]w", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
	vim.api.nvim_feedkeys("zz", "n", false)
end)
-- Goto previous warning diagnostic
  nnoremap("[w", function()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
    vim.api.nvim_feedkeys("zz", "n", false)
  end)

-- Place all dignostics into a qflist
nnoremap("<leader>ld", vim.diagnostic.setqflist, { desc = "Quickfix [L]ist [D]iagnostics" })
-- Navigate to next qflist item
nnoremap("<leader>cn", ":cnext<cr>zz")
-- Navigate to previos qflist item
nnoremap("<leader>cp", ":cprevious<cr>zz")
-- Open the qflist
nnoremap("<leader>co", ":copen<cr>zz")
-- Close the qflist
nnoremap("<leader>cc", ":cclose<cr>zz")
-- Map MaximizerToggle (szw/vim-maximizer) to leader-m
nnoremap("<leader>m", ":MaximizerToggle<cr>")
-- Resize split windows to be equal size
nnoremap("<leader>=", "<C-w>=")
-- Press leader rw to rotate open windows
nnoremap("<leader>rw", ":RotateWindows<cr>", { desc = "[R]otate [W]indows" })
-- Press gx to open the link under the cursor
nnoremap("gx", ":sil !open <cWORD><cr>", { silent = true })
-- Harpoon keybinds --
-- Open harpoon ui
nnoremap("<leader>ho", function()
	harpoon_ui.toggle_quick_menu()
end)
-- Add current file to harpoon
nnoremap("<leader>ha", function()
	harpoon_mark.add_file()
end)
-- Remove current file from harpoon
nnoremap("<leader>hr", function()
	harpoon_mark.rm_file()
end)
-- Remove all files from harpoon
nnoremap("<leader>hc", function()
	harpoon_mark.clear_all()
end)
-- Quickly jump to harpooned files
nnoremap("<leader>1", function()
	harpoon_ui.nav_file(1)
end)
nnoremap("<leader>2", function()
	harpoon_ui.nav_file(2)
end)
nnoremap("<leader>3", function()
	harpoon_ui.nav_file(3)
end)
nnoremap("<leader>4", function()
	harpoon_ui.nav_file(4)
end)
nnoremap("<leader>5", function()
	harpoon_ui.nav_file(5)
end)
-- Git keymaps --
nnoremap("<leader>gb", ":Gitsigns toggle_current_line_blame<cr>")
nnoremap("<leader>gf", function()
	local cmd = {
		"sort",
		"-u",
		"<(git diff --name-only --cached)",
		"<(git diff --name-only)",
		"<(git diff --name-only --diff-filter=U)",
	}

	if not utils.is_git_directory() then
		vim.notify(
			"Current project is not a git directory",
			vim.log.levels.WARN,
			{ title = "Telescope Git Files", git_command = cmd }
		)
	else
		require("telescope.builtin").git_files()
	end
end, { desc = "Search [G]it [F]iles" })

-- Telescope keybinds --
nnoremap("<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
nnoremap("<leader>fb", require("telescope.builtin").buffers, { desc = "[F]ind Open [B]uffers" })
nnoremap("<leader>ff", function()
	require("telescope.builtin").find_files({ hidden = true })
end, { desc = "[S]earch [F]iles" })
nnoremap("<leader>fh", require("telescope.builtin").help_tags, { desc = "[F]ind [H]elp" })
nnoremap("<leader>fg", require("telescope.builtin").live_grep, { desc = "[F]ind by [G]rep" })
nnoremap('<leader>fgs', require("telescope.builtin").git_status, { desc = '[F]ind [G]it [S]status' })

nnoremap("<leader>fc", function()
	require("telescope.builtin").commands(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end, { desc = "[F]ind [C]ommands" })

nnoremap("<leader>/", function()
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer]" })

nnoremap("<leader>ss", function()
	require("telescope.builtin").spell_suggest(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end, { desc = "[S]earch [S]pelling suggestions" })

-- LSP Keybinds (exports a function to be used in ../../after/plugin/lsp.lua b/c we need a reference to the current buffer) --
M.map_lsp_keybinds = function(buffer_number)
	nnoremap("<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame", buffer = buffer_number })
	nnoremap("<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction", buffer = buffer_number })
	nnoremap("gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition", buffer = buffer_number })
	-- Telescope LSP keybinds --
	nnoremap(
		"gr",
		require("telescope.builtin").lsp_references,
		{ desc = "LSP: [G]oto [R]eferences", buffer = buffer_number }
	)
	nnoremap(
		"gi",
		require("telescope.builtin").lsp_implementations,
		{ desc = "LSP: [G]oto [I]mplementation", buffer = buffer_number }
	)
	nnoremap(
		"<leader>bs",
		require("telescope.builtin").lsp_document_symbols,
		{ desc = "LSP: [B]uffer [S]ymbols", buffer = buffer_number }
	)
	nnoremap(
		"<leader>ps",
		require("telescope.builtin").lsp_workspace_symbols,
		{ desc = "LSP: [P]roject [S]ymbols", buffer = buffer_number }
	)
	-- See `:help K` for why this keymap
	nnoremap("K", vim.lsp.buf.hover, { desc = "LSP: Hover Documentation", buffer = buffer_number })
	nnoremap("<leader>k", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })
	inoremap("<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })
	-- Lesser used LSP functionality
	nnoremap("gD", vim.lsp.buf.declaration, { desc = "LSP: [G]oto [D]eclaration", buffer = buffer_number })
	nnoremap("td", vim.lsp.buf.type_definition, { desc = "LSP: [T]ype [D]efinition", buffer = buffer_number })
end
nnoremap('<leader>af', ':LspZeroFormat<CR>')

-- Symbol Outline keybind
nnoremap("<leader>so", ":SymbolsOutline<cr>")

-- Vim Illuminate keybinds
nnoremap("<leader>]", function()
	illuminate.goto_next_reference()
	vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Illuminate: Goto next reference" })

nnoremap("<leader>[", function()
	illuminate.goto_prev_reference()
	vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Illuminate: Goto previous reference" })

-- Open Copilot panel
nnoremap("<leader>oc", function()
	require("copilot.panel").open({})
end, { desc = "[O]pen [C]opilot panel" })

-- nvim-ufo keybinds
nnoremap("zR", require("ufo").openAllFolds)
nnoremap("zM", require("ufo").closeAllFolds)

-- Visual --
-- Disable Space bar since it'll be used as the leader key
vnoremap("<space>", "<nop>")

-- Press 'H', 'L' to jump to start/end of a line (first/last char)
vnoremap("L", "$<left>")
vnoremap("H", "^")

-- Move selected text up/down in visual mode
vnoremap("<A-j>", ":m '>+1<CR>gv=gv")
vnoremap("<A-k>", ":m '<-2<CR>gv=gv")

-- Reselect the last visual selection
xnoremap("<<", function()
	vim.cmd("normal! <<")
	vim.cmd("normal! gv")
end)

xnoremap(">>", function()
	vim.cmd("normal! >>")
	vim.cmd("normal! gv")
end)

-- Ruby on Rails keybinds
nnoremap("<Leader>fr", ":lua require('ror.commands').list_commands()<CR>", { silent = true })
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
nnoremap('<leader><', ':lua insert_erb_tag("output")<CR>', { noremap = true, silent = true })
nnoremap('<leader>>', ':lua insert_erb_tag("execution")<CR>', { noremap = true, silent = true })
nnoremap('<leader>,', ':lua insert_erb_tag("execution_trim")<CR>', { noremap = true, silent = true })


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

-- Debugging keymaps
vim.keymap.set('n', '<leader>dt', '<cmd>lua require("dapui").toggle()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>dc', '<cmd>lua require"dap".continue()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>b', '<cmd>lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>i', '<cmd>lua require"dap".step_into()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>n', '<cmd>lua require"dap".step_over()<CR>', { noremap = true, silent = true })
-- Sneak keymaps
vim.api.nvim_set_keymap('n', 'f', '<Plug>Sneak_s', {silent = true})
vim.api.nvim_set_keymap('n', 'F', '<Plug>Sneak_S', {silent = true})


return M
