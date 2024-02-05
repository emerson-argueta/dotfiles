return {
	{ 'mfussenegger/nvim-dap' },
	{ 'ldelossa/nvim-dap-projects' },
	{ 'theHamsta/nvim-dap-virtual-text' },
	{
		'rcarriga/nvim-dap-ui',
		config = function()
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
		end

	},
}

