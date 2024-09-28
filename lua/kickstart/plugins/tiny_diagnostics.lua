return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy", -- Or `LspAttach`
  config = function()
    vim.diagnostic.config({ virtual_text = false })
    require('tiny-inline-diagnostic').setup({
      options = {
        multilines = true,
      }
    })
  end
}
