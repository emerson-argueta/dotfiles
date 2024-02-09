return {
  {
    "catppuccin/nvim",
    config = function()
      require("catppuccin").setup({
        background = { -- :h background
          light = "latte",
          dark = "macchiato",
        },
        color_overrides = {
          latte = {
            rosewater = "#A0A0A0",
            flamingo = "#969696",
            pink = "#A2A2A2",
            mauve = "#646464",
            red = "#4E4E4E",
            maroon = "#767676",
            peach = "#888888",
            yellow = "#999999",
            green = "#767676",
            teal = "#6D6D6D",
            sky = "#7B7B7B",
            sapphire = "#7B7B7B",
            blue = "#606060",
            lavender = "#8D8D8D",
            text = "#505050",
            subtext1 = "#606060",
            subtext0 = "#707070",
            overlay2 = "#808080",
            overlay1 = "#909090",
            overlay0 = "#A0A0A0",
            surface2 = "#B0B0B0",
            surface1 = "#C0C0C0",
            surface0 = "#CFCFCF",
            base = "#E8E8E8",
            mantle = "#F0F0F0",
            crust = "#DFDFDF",

          },
          macchiato = {
            rosewater = '#dfdfdf',
            flamingo = '#cecece',
            pink = '#cbcbcb',
            mauve = '#aeaeae',
            red = '#9d9d9d',
            maroon = '#ababab',
            peach = '#b6b6b6',
            yellow = '#d5d5d5',
            green = '#c9c9c9',
            teal = '#c4c4c4',
            sky = '#c8c8c8',
            sapphire = '#b7b7b7',
            blue = '#aaaaaa',
            lavender = '#bfbfbf',
            text = '#d3d3d3',
            subtext1 = '#c0c0c0',
            subtext0 = '#adadad',
            overlay2 = '#9a9a9a',
            overlay1 = '#878787',
            overlay0 = '#737373',
            surface2 = '#606060',
            surface1 = '#4d4d4d',
            surface0 = '#3a3a3a',
            base = '#272727',
            mantle = '#202020',
            crust = '#191919'
          },
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          harpoon = true,
          illuminate = true,
          indent_blankline = {
            enabled = false,
            scope_color = "sapphire",
            colored_indent_levels = false,
          },
          mason = true,
          native_lsp = { enabled = true },
          notify = true,
          nvimtree = true,
          neotree = true,
          symbols_outline = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
        },
      })

      vim.cmd.colorscheme('catppuccin')
      vim.cmd('set background=dark')
      -- Hide all semantic highlights until upstream issues are resolved (https://github.com/catppuccin/nvim/issues/480)
      for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
      end
    end,
  },
  {
    "RRethy/nvim-base16",
    config = function()
      -- vim.cmd('colorscheme base16-grayscale-light')
    end
  },
}
