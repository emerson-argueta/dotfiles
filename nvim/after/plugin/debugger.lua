local dap, dapui = require("dap"), require("dapui")
require('nvim-dap-projects').search_project_config()
dapui.setup()
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map('n', '<leader>dt', '<cmd>lua require("dapui").toggle()<CR>', opts)
map('n', '<leader>dc', '<cmd>lua require"dap".continue()<CR>', opts)
map('n', '<leader>b', '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
map('n', '<leader>i', '<cmd>lua require"dap".step_into()<CR>', opts)
map('n', '<leader>n', '<cmd>lua require"dap".step_over()<CR>', opts)
