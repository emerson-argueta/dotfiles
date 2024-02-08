return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = vim.fn.executable("make") == 1,
      },
    },
    config = function()
      local function find_files_including_custom_patterns(patterns)
        local Job = require 'plenary.job'
        local included_files = {}
        local other_files = {}
        local all_files = {}

        -- Function to merge and remove duplicates
        local function merge_tables(t1, t2)
          local hash = {}
          for _, v in ipairs(t1) do
            if not hash[v] then
              table.insert(all_files, v)
              hash[v] = true
            end
          end
          for _, v in ipairs(t2) do
            if not hash[v] then
              table.insert(all_files, v)
              hash[v] = true
            end
          end
        end

        -- Find custom pattern files, ignoring .gitignore
        for _, pattern in ipairs(patterns) do
          Job:new({
            command = 'rg',
            args = { '--files', '--hidden', '--glob', pattern, '--no-ignore' },
            cwd = vim.fn.getcwd(),
            on_exit = function(j, return_val)
              local result = j:result()
              for _, file in ipairs(result) do
                table.insert(included_files, file)
              end
            end,
          }):sync()
        end

        -- Find all other files, respecting .gitignore
        Job:new({
          command = 'rg',
          args = { '--files', '--hidden' },
          cwd = vim.fn.getcwd(),
          on_exit = function(j, return_val)
            other_files = j:result()
          end,
        }):sync()

        -- Merge lists, ensuring uniqueness
        merge_tables(included_files, other_files)

        -- Use Telescope to list these files
        require 'telescope.builtin'.find_files({ find_command = { 'echo', table.concat(all_files, '\n') } })
      end

      vim.api.nvim_create_user_command('FindCustomFiles', function(input)
        local patterns = vim.split(input.args, ",", true)
        find_files_including_custom_patterns(patterns)
      end, { nargs = '+' })

      local actions = require("telescope.actions")

      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-x>"] = actions.delete_buffer,
            },
          },
          file_ignore_patterns = {
            "node_modules",
            "yarn.lock",
            ".git",
            ".sl",
            "_build",
            ".next",
          }
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
          }
        },
      })

      -- Enable telescope fzf native, if installed
      pcall(require("telescope").load_extension, "fzf")
    end,
  },
}
