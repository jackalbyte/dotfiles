local M = {}

function M.setup()
  vim.keymap.set("n", "<Leader>bp", ":lua require('dap').toggle_breakpoint()<CR>")
  vim.keymap.set("n", "<Leader>bP", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
  vim.keymap.set("n", "<Leader>dbm", ":lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")

  vim.keymap.set("n", "<Leader>du", ":lua require('dapui').toggle()<CR>")

  vim.keymap.set("n", "<Leader>dd", ":lua require('dap').continue()<CR>")
  vim.keymap.set("n", "<F9>", ":lua require('dap').continue()<CR>")

  vim.keymap.set("n", "<Leader>dl", ":lua require('dap').step_over()<CR>")
  vim.keymap.set("n", "<F8>", ":lua require('dap').step_over()<CR>")

  vim.keymap.set("n", "<Leader>dj", ":lua require('dap').step_into()<CR>")
  vim.keymap.set("n", "<F7>", ":lua require('dap').step_into()<CR>")

  vim.keymap.set("n", "<Leader>dL", ":lua require('dap').step_over()<CR>")
  vim.keymap.set("n", "<S-F9>", ":lua require('dap').run_to_cursor()<CR>")

  vim.keymap.set("n", "<Leader>dk", ":lua require('dap').step_out()<CR>")
  vim.keymap.set("n", "<S-F8>", ":lua require('dap').step_out()<CR>")

  vim.keymap.set("n", "<Leader>dc", ":lua require('dap').close()<CR>")
  vim.keymap.set("n", "<Leader>dt", ":lua require('dap').terminate()<CR>")
  vim.keymap.set("n", "<Leader>dr", ":lua require('dap.repl').toggle()<CR>")
  --vim.keymap.set("n", "<Leader>drl", ":lua require('dap').repl.run_last()<CR>")

  vim.keymap.set({'n', 'v'}, '<Leader>de', function() require('dapui').eval(nil, {enter=true}) end)

  vim.keymap.set({'n', 'v'}, '<Leader>dp', function() require('dap.ui.widgets').preview() end)
  vim.keymap.set({'n', 'v'}, '<Leader>dh', function() require('dap.ui.widgets').hover() end)
  vim.keymap.set('n', '<Leader>df', function() local widgets = require('dap.ui.widgets') widgets.centered_float(widgets.frames) end)
  vim.keymap.set('n', '<Leader>ds', function() local widgets = require('dap.ui.widgets') widgets.centered_float(widgets.scopes) end)

  --lua require("dapui").float_element("stacks", { enter=true , position=center})
end

return M
