--  https://github.com/lewis6991/gitsigns.nvim
return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        map('n', '<leader>gcp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
      end,
    },
  },
  --  To enable this feature, add this  to your global .gitconfig:
  --
  --  [mergetool "fugitive"]
  --  	cmd = nvim -c \"Gvdiffsplit!\" \"$MERGED\"
  --  [merge]
  --  	tool = fugitive
  --  [mergetool]
  --  	keepBackup = false
  {
    'tpope/vim-fugitive',
    enabled = vim.fn.executable 'git' == 1,
    dependencies = { 'tpope/vim-rhubarb' },
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = 'Git status' })
      vim.keymap.set('n', '<leader>gB', ':GBrowse<CR>', { desc = 'Open in github' })
      vim.keymap.set("n", "<leader>gL", ":Git log --graph --decorate<CR>", { desc = 'Git log' })
      vim.keymap.set("n", "<leader>gl", ":Git log --graph --decorate --oneline<CR>", { desc = 'Git log one line' })

      vim.keymap.set("n", "<leader>gd", "<cmd>diffget //2<CR>", { desc = 'Git diffget 2' })
      vim.keymap.set("n", "<leader>gD", "<cmd>diffget //3<CR>", { desc = 'Git diffget 2' })

      vim.keymap.set("n", "<leader>gp", function()
        vim.cmd.Git('push')
      end, { desc = 'Git push' })

      -- rebase always
      vim.keymap.set("n", "<leader>gP", function()
          vim.cmd.Git({'pull',  '--rebase'})
      end, { desc = 'Git pull rebase' })
    end,
  },
}
