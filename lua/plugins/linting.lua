return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        swift = { "swiftlint" },
      },
      linters = {
        swiftlint = {
          cmd = "swiftlint",
          stdin_filename = function()
            return vim.fn.expand("%")
          end,
          args = { "lint", "--use-stdin" },
          stream = "stdout",
          ignore_exitcode = true,
          parser = require("lint.parser").from_pattern(
            "([^:]+):(%d+):(%d+): ([^:]+): (.*)",
            { "file", "lnum", "col", "severity", "message" },
            { severity = require("lint").severities }
          ),
        },
      },
    },
  },
}
