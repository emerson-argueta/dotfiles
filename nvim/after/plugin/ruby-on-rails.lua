require("dressing").setup({
  input = {
    min_width = { 60, 0.9 },
  },
  select = {
    -- telescope = require('telescope.themes').get_ivy({...})
    telescope = require('telescope.themes').get_dropdown({ layout_config = { height = 30, width = 180 } }), }
})

-- The default settings
require("ror").setup({
  test = {
    message = {
      -- These are the default title for nvim-notify
      file = "Running test file...",
      line = "Running single test..."
    },
    coverage = {
      -- To customize replace with the hex color you want for the highlight
      -- guibg=#354a39
      up = "DiffAdd",
      -- guibg=#4a3536
      down = "DiffDelete",
    },
    notification = {
      -- Using timeout false will replace the progress notification window
      -- Otherwise, the progress and the result will be a different notification window
      timeout = false
    },
    pass_icon = "✅",
    fail_icon = "❌"
  }
})

-- Set a keybind
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
vim.api.nvim_set_keymap('n', '<leader><', ':lua insert_erb_tag("output")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>>', ':lua insert_erb_tag("execution")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>,', ':lua insert_erb_tag("execution_trim")<CR>', { noremap = true, silent = true })

