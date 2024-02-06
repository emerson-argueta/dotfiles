return {
  {
    "catppuccin/nvim",
    config = function()
      require("catppuccin").setup({
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

      vim.cmd.colorscheme("catppuccin-latte")

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
