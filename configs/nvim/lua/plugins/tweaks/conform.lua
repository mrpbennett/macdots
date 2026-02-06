return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      sql = { "sqruff" },
      yaml = { "yamlfmt" },
    },
    formatters = {
      sqruff = {
        command = "sqruff",
        args = { "fix", "--config", vim.fn.expand("~/.config/sqruff/.sqruff"), "-" },
        stdin = true,
      },
      yamlfmt = {
        command = "yamlfmt",
        args = { "-formatter", "basic", "-indentless_arrays=true" },
      },
    },
  },
}
