-- https://github.com/gsuuon/model.nvim
return {
  'gsuuon/model.nvim',
  -- Don't need these if lazy = false
  cmd = { 'M', 'Model', 'Mchat' },
  init = function()
    vim.filetype.add({
      extension = {
        mchat = 'mchat',
      }
    })
  end,
  ft = 'mchat',

  keys = {
    {'<C-m>d', ':Mdelete<cr>', mode = 'n'},
    {'<C-m>s', ':Mselect<cr>', mode = 'n'},
    {'<C-m><space>', ':Mchat<cr>', mode = 'n' }
  },

  config = function()
    local llamacpp = require('model.providers.llamacpp')

    require('model').setup({
      default_prompt = 'queen',
      prompts = {
        -- instruct = { ... },
        -- code = { ... },
        -- ask = { ... },

        queen = {
          provider = llamacpp,
          options = {
            url = 'http://localhost:9091'
          },
            builder = function(input, context)
              return {
                prompt =
                  '<|system|>'
                  .. (context.args or 'You are a helpful assistant')
                  .. '\n</s>\n<|user|>\n'
                  .. input
                  .. '</s>\n<|assistant|>',
                stops = { '</s>' }
              }
            end
        },
          ['to javascript'] = {
          provider = llamacpp,
          options = {
            url = 'http://localhost:9091'
          },
          builder = function(input, ctx)
            return {
              messages = {
                {
                  role = 'system',
                  content = 'Convert the code to javascript'
                },
                {
                  role = 'user',
                  content = input
                }
              }
            }
        end,
      },       
      },
      chats = {     
        queen = {
          provider = llamacpp,
          options = {
            url = 'http://localhost:9091'
          },
          builder = function(input, context)
            return {
              prompt =
                '<|system|>'
                .. (context.args or 'You are a helpful assistant')
                .. '\n</s>\n<|user|>\n'
                .. input
                .. '</s>\n<|assistant|>',
              stops = { '</s>' }
            }
          end
        }
      }
    })
  end

}
