return {
  {
    "nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        sourcekit = {
          cmd = { "sourcekit-lsp" },
          filetypes = { "swift", "objc", "objcpp", "c", "cpp" },
          root_dir = function(filename, _)
            return require("lspconfig.util").root_pattern("Package.swift", ".git")(filename)
          end,
        },
      },
    },
  },
}
