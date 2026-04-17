vim.lsp.enable({
  "gopls",
  "lua_ls",
  "pyright",
  "intelephense",
  "ts"
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    -- defaults:
    -- https://neovim.io/doc/user/news-0.11.html#_defaults
    local opts = {}
    vim.keymap.set("n", "gv", function()
      vim.cmd('vsplit')
      vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>a", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>l", function() vim.lsp.codelens.run() end, opts)
    vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    local ok, telescope = pcall(require, "telescope.builtin")
    if ok then
      vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
      vim.keymap.set("n", "gD", telescope.lsp_type_definitions, opts)
      vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
      vim.keymap.set("n", "gr", telescope.lsp_references, opts)
      vim.keymap.set("n", "gI", telescope.lsp_incoming_calls, opts)
      vim.keymap.set("n", "gO", telescope.lsp_outgoing_calls, opts)

      local symbols_style = {
        symbols = {"Function", "Method", "Class", "Interface"},
        symbol_width = 50,
      }
      vim.keymap.set("n", "<leader>s", function() telescope.lsp_document_symbols(symbols_style) end, opts)
    end

    local function client_supports_method(client, method, bufnr)
      if vim.fn.has 'nvim-0.11' == 1 then
        return client:supports_method(method, bufnr)
      else
        return client.supports_method(method, { bufnr = bufnr })
      end
    end

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

      -- When cursor stops moving: Highlights all instances of the symbol under the cursor
      -- When cursor moves: Clears the highlighting
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      -- When LSP detaches: Clears the highlighting
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end,

})

vim.diagnostic.config({
  virtual_lines = false,
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = true,
  },
})

--require("lsp.gopls")
