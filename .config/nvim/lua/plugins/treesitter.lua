vim.pack.add({
  {
    -- tree-sitter CLI must be installed system-wide
    src = "https://github.com/romus204/tree-sitter-manager.nvim",
  },
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter-context",
  },
})

require("tree-sitter-manager").setup({
  -- Optional: custom paths
  -- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
  -- query_dir = vim.fn.stdpath("data") .. "/site/queries",
  ensure_installed = {"go","typescript"},
})

require("treesitter-context").setup({
  max_lines = 3,
})
