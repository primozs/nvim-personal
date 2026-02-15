return {
  {
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        swift = { "swiftformat" },
      },
      formatters = {
        swiftformat = {
          command = "swiftformat",
        },
      },
    },
  },
}
