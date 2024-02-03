return {
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		dependencies = {
			{ 'williamboman/mason.nvim' },
			{ 'williamboman/mason-lspconfig.nvim' },
			{ "folke/neodev.nvim" },
			{ 'neovim/nvim-lspconfig' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/nvim-cmp' },
			{ 'L3MON4D3/LuaSnip' },
		},
		config = function()
			-- Use neodev to configure lua_ls in nvim directories - must load before lspconfig
			require("neodev").setup()
			local lsp_zero = require('lsp-zero')
			lsp_zero.on_attach(function(client, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				require('user.keymaps').lsp_keymaps(bufnr)
			end)

			-- to learn how to use mason.nvim with lsp-zero
			-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
			require('mason').setup({ ui = { border = "rounded" } })
			require('mason-lspconfig').setup({
				ensure_installed = {
					"ruby_ls",
					"solargraph",
					"gopls",
					"rubocop",
					"html",
					"tailwindcss",
					"templ",
					"tsserver",
					"lua_ls",
					"sqlls",
					"htmx",
				},
				handlers = {
					lsp_zero.default_setup,
				},
			})

			local cmp = require('cmp')
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			cmp.setup({
				sources = {
					{ name = 'path' },
					{ name = 'nvim_lsp' },
					{ name = 'nvim_lua' },
					{ name = 'luasnip', keyword_length = 2 },
					{ name = 'buffer',  keyword_length = 3 },
				},
				formatting = lsp_zero.cmp_format(),
				mapping = cmp.mapping.preset.insert({
					['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
					['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
					['<C-Space>'] = cmp.mapping.complete(),
				}),
			})


			-- Option 2: nvim lsp as LSP client
			-- Tell the server the capability of foldingRange,
			-- Neovim hasn't added foldingRange to default capabilities, users must add it manually
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true
			}
			local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
			for _, ls in ipairs(language_servers) do
				require('lspconfig')[ls].setup({
					capabilities = capabilities
					-- you can add other fields for setting up lsp server in this table
				})
			end
			local lspconfig = require('lspconfig')
			-- Ruby LSP setup
			lspconfig.ruby_ls.setup {
				filetypes = { "ruby", "eruby" }
			}
			-- HTML LSP setup
			lspconfig.html.setup {
				filetypes = { "html", "eruby" }
			}
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			require 'nvim-treesitter.configs'.setup {
				-- A list of parser names, or "all" (the five listed parsers should always be installed)
				ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "ruby", "go", "html", "embedded_template" },
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
				autopairs = {
					enable = true,
				},
				autotag = {
					enable = true,
				},
			}
		end,
	},
	{
		'kevinhwang91/nvim-ufo',
		event = "BufEnter",
		dependencies = 'kevinhwang91/promise-async',
		config = function()
			require("ufo").setup({
				--- @diagnostic disable-next-line: unused-local
				provider_selector = function(_bufnr, _filetype, _buftype)
					return { "treesitter", "indent" }
				end,
			})
		end
	},
}
