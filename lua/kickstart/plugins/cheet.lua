return {
  'RishabhRD/nvim-cheat.sh',
  event = 'VeryLazy',
  dependencies = {
    'RishabhRD/popfix',
  },
  init = function()
    vim.g.cheat_default_window_layout = 'vertical_split'
    vim.keymap.set('n', '<leader>ch', '<cmd>Cheat<CR>', { noremap = true, silent = true })
  end,
}
