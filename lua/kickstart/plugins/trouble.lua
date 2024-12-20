-- https://github.com/folke/trouble.nvim

return {
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        keys = {
            {
                "<leader>td",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
        },
        -- config = function()
    --         require("trouble").setup({

    --         })

    --         vim.keymap.set("n", "<leader>tt", function()
    --             require("trouble").toggle()
    --         end, { desc = 'Toggle trouble' })

    --         vim.keymap.set("n", "[t", function()
    --             require("trouble").next({skip_groups = true, jump = true});
    --         end, { desc = 'Trouble next' })

    --         vim.keymap.set("n", "]t", function()
    --             require("trouble").previous({skip_groups = true, jump = true});
    --         end, { desc = 'Trouble prev' })

        -- end
    },
}
