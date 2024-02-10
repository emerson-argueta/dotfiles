vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function()
    vim.opt_local.colorcolumn = ""
  end,
})

return {
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      config = function()
        require('nvim-web-devicons').setup({
          color_icons = false,
        })
      end
    },
    config = function()
      local oil = require('oil')
      -- Define function to toggle special files display
      local function toggleFileInfo()
        local cols = require('oil.config').columns
        local has_info = false
        for _, v in pairs(cols) do
          if v == 'permissions' then
            has_info = true
            break
          end
        end
        if has_info then
          oil.set_columns({
            "icon",
          })
          return
        end

        oil.set_columns({
          "icon",
          "permissions",
          "size",
          "mtime",
        })
      end

      -- Map command to toggle file info

      oil.setup({
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-\\>"] = "actions.select_vsplit",
          ["<C-enter>"] = "actions.select_split", -- this is used to navigate left
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-r>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
          ["<leader>fi"] = toggleFileInfo, -- Define a leader key mapping to toggle file info
        },
        use_default_keymaps = false,
        view_options = {
          show_hidden = true
        }
      })
    end,
  },
}
