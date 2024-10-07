return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup()

    -- basic telescope configuration
    -- local conf = require("telescope.config").values
    -- local function toggle_telescope(harpoon_files)
    --     local file_paths = {}
    --     for _, item in ipairs(harpoon_files.items) do
    --         table.insert(file_paths, item.value)
    --     end

    --     require("telescope.pickers").new({}, {
    --         prompt_title = "Harpoon",
    --         finder = require("telescope.finders").new_table({
    --             results = file_paths,
    --         }),
    --         previewer = conf.file_previewer({}),
    --         sorter = conf.generic_sorter({}),
    --     }):find()
    -- end

    -- vim.keymap.set('n', '<leader>a', function()
    --   harpoon:list():add()
    -- end, { desc = 'Harpoon list add' })
    -- vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end, { desc = "Harpoon open" })
    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon open' })

    vim.keymap.set('n', '<S-H>', function()
      harpoon:list():select(1)
    end, { desc = 'Harpoon 1' })
    vim.keymap.set('n', '<S-J>', function()
      harpoon:list():select(2)
    end, { desc = 'Harpoon 2' })
    vim.keymap.set('n', '<S-K>', function()
      harpoon:list():select(3)
    end, { desc = 'Harpoon 3' })
    vim.keymap.set('n', '<S-L>', function()
      harpoon:list():select(4)
    end, { desc = 'Harpoon 4' })
    vim.keymap.set('n', '<leader><S-H>', function()
      harpoon:list():replace_at(1)
    end, { desc = 'Harpoon add 1' })
    vim.keymap.set('n', '<leader><S-J>', function()
      harpoon:list():replace_at(2)
    end, { desc = 'Harpoon add 2' })
    vim.keymap.set('n', '<leader><S-K>', function()
      harpoon:list():replace_at(3)
    end, { desc = 'Harpoon add 3' })
    vim.keymap.set('n', '<leader><S-L>', function()
      harpoon:list():replace_at(4)
    end, { desc = 'Harpoon add 4' })

    harpoon:extend {
      UI_CREATE = function(cx)
        vim.keymap.set('n', '<C-V>', function()
          harpoon.ui:select_menu_item { vsplit = true }
        end, { buffer = cx.bufnr })

        vim.keymap.set('n', '<C-S>', function()
          harpoon.ui:select_menu_item { split = true }
        end, { buffer = cx.bufnr })

        vim.keymap.set('n', '<C-t>', function()
          harpoon.ui:select_menu_item { tabedit = true }
        end, { buffer = cx.bufnr })
      end,
    }
  end,
}
