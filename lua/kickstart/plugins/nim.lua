  -- https://nim-lang.org/docs/tools.html
  -- https://nim-lang.org/docs/nimsuggest.html
  -- https://github.com/nim-lang/Nim/wiki/Editor-Support
  -- https://github.com/alaviss/nim.nvim?tab=readme-ov-file
  -- https://github.com/PMunch/nimlsp

  -- {
  --   'alaviss/nim.nvim',
  --   config = function()
  --     vim.opt.foldlevelstart = 99
  --     vim.opt.foldmethod = 'manual'
  --   end,
  -- },

  vim.g.scorpeon_extensions_path = vim.fn.expand("~/.config/nvim/vscode")
  vim.g.scorpeon_highlight = {
    enable = {'nim', "nimble", "nims", "cfg"},
    disable= function ()
      return false
    end
  }
  
  vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    callback = function(t)
      local fn = vim.api.nvim_buf_get_name(t.buf)
      if string.match(fn, '/?%.nims') or string.match(fn, '/?%.nimble') then
        vim.diagnostic.disable(t.buf)
      end
    end
  })

  return {
    'uga-rosa/scorpeon.vim',
    dependencies = {
      'vim-denops/denops.vim',
    }
  }
