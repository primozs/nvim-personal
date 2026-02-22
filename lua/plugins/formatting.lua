return {
  {
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        swift = { "swiftformat" },
        mojo = { "mojo" },
      },
      formatters = {
        swiftformat = {
          command = "swiftformat",
        },
        mojo = {
          command = "mojo",
          args = { "format", "-" },
          stdin = true,
        },
      },
    },
  },
}
