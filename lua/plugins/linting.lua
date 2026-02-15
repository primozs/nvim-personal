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
          args = { "lint", "--use-stdin", "--reporter", "json" },
          stdin_filename = vim.fn.expand("%"),
          stream = "stdout",
          ignore_exitcode = true,
          parser = function(output)
            local diagnostics = {}
            local ok, data = pcall(vim.json.decode, output)
            if ok and data then
              for _, issue in ipairs(data) do
                table.insert(diagnostics, {
                  lnum = issue.line - 1,
                  col = issue.character - 1,
                  message = issue.reason,
                  severity = issue.severity:upper() == "ERROR" and vim.diagnostic.severity.ERROR
                    or vim.diagnostic.severity.WARN,
                })
              end
            end
            return diagnostics
          end,
        },
      },
    },
  },
}
