local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  group = vim.api.nvim_create_augroup("GoFormat", { clear = true }),
  callback = function()
    -- Organize imports через gopls
    vim.lsp.buf.code_action({
      context = { only = { "source.organizeImports" } },
      apply = true,
    })
    -- Форматирование через gopls
    vim.lsp.buf.format({ async = false })
  end,
})
