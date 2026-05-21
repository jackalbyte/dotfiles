return {
  vim.lsp.config("gopls", {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl", "gosum" },
    root_markers = { "go.mod", "go.work", ".git" },
    on_attach = function(client, bufnr)
      local opts = { buffer = bufnr }

      vim.keymap.set('n', 'gd', function()
        local params = vim.lsp.util.make_position_params()
        vim.lsp.buf_request(bufnr, 'textDocument/definition', params, function(_, result)
          if not result or vim.tbl_isempty(result) then return end

          -- Handle both single Location and LocationLink[]
          local location = vim.tbl_islist(result) and result[1] or result

          -- Replacement for deprecated jump_to_location
          vim.lsp.util.show_document(location, client.offset_encoding, { focus = true })
        end)
      end, opts)
    end,
    settings = {
      gopls = {
        env = {
          GOPROXY = vim.env.GOPROXY or "direct",
        },
        gofumpt = true,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = false,
          compositeLiteralFields = false,
          compositeLiteralTypes = false,
          constantValues = false,
          functionTypeParameters = false,
          parameterNames = false,
          rangeVariableTypes = false,
        },
        analyses = {
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
          unreachable = true,
          modernize = true,
          stylecheck = false,
          appends = true,
          asmdecl = true,
          assign = true,
          atomic = true,
          bools = true,
          buildtag = true,
          cgocall = true,
          composite = true,
          contextcheck = true,
          deba = true,
          atomicalign = true,
          composites = true,
          copylocks = true,
          deepEqualerrors = true,
          defers = true,
          deprecated = true,
          directive = true,
          embed = true,
          errorsas = true,
          fillreturns = true,
          framepointer = true,
          gofix = true,
          hostport = true,
          infertypeargs = true,
          lostcancel = true,
          httpresponse = true,
          ifaceassert = true,
          loopclosure = true,
          nilfunc = true,
          nonewvars = true,
          noresultvalues = true,
          printf = true,
          shadow = true,
          shift = true,
          sigchanyzer = true,
          simplifycompositelit = true,
          simplifyrange = true,
          simplifyslice = true,
          slog = true,
          sortslice = true,
          stdmethods = true,
          stdversion = true,
          stringintconv = true,
          structtag = true,
          testinggoroutine = true,
          tests = true,
          timeformat = true,
          unmarshal = true,
          unsafeptr = true,
          unusedfunc = true,
          unusedresult = true,
          waitgroup = true,
          yield = true,
          unusedvariable = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
        semanticTokens = true,
      },
    },
  })
}
