return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      -- Plugin and UI to automatically install LSPs to stdpath
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      -- Install none-ls for diagnostics, code actions, and formatting
      "nvimtools/none-ls.nvim",
      -- Install neodev for better nvim configuration and plugin authoring via lsp configurations
      "folke/neodev.nvim",
      -- Progress/Status update for LSP
      { "j-hui/fidget.nvim",    tag = "legacy" },
      { 'neovim/nvim-lspconfig' },
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
        require('user.keymaps').map_lsp_keybinds(bufnr)
      end)

      -- Setup mason so it can manage 3rd party LSP servers
      require("mason").setup({
        ui = {
          border = "rounded",
        },
      })

      -- Configure mason to auto install servers
      require("mason-lspconfig").setup({
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
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
          { name = "vim-dadbod-completion", priority = 700 }, -- add new source
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
      -- Configure borderd for LspInfo ui
      require("lspconfig.ui.windows").default_options.border = "rounded"

      -- Configure diagostics border
      vim.diagnostic.config({
        float = {
          border = "rounded",
        },
      })
    end,
  },
}
