local M = {}

function M.setup()
  local enabled = require("config.flags")

  local specs = {
    { src = "https://github.com/nvim-neotest/nvim-nio" },
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/rcarriga/nvim-dap-ui" },
    { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-dap.nvim" },
  }

  if enabled.dap.go then
    table.insert(specs, { src = "https://github.com/leoluz/nvim-dap-go" })
  end

  vim.pack.add(specs)

  local ok_dap, dap = pcall(require, "dap")
  if not ok_dap then
    vim.notify("nvim-dap failed to load", vim.log.levels.ERROR)
    return
  end

  if type(dap.listeners) ~= "table" then
    vim.notify("nvim-dap loaded without listeners table", vim.log.levels.ERROR)
    return
  end

  local function configure_signs()
    vim.fn.sign_define("DapBreakpoint", {
      text = "󰃤",
      texthl = "DiagnosticSignError",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapStopped", {
      text = "",
      texthl = "DiagnosticSignInfo",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "DiagnosticSignInfo",
    })

    vim.fn.sign_define("DapBreakpointRejected", {
      text = "󰨰",
      texthl = "DiagnosticSignHint",
      linehl = "",
      numhl = "",
    })
  end

  local function configure_virtual_text()
    local ok_vt, vt = pcall(require, "nvim-dap-virtual-text")
    if not ok_vt then
      return
    end

    vt.setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = true,
      only_first_definition = true,
      all_references = false,
      clear_on_continue = false,
      virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
    })
  end

  local function configure_ui()
    local ok_dapui, dapui = pcall(require, "dapui")
    if not ok_dapui then
      return
    end

    dapui.setup({
      expand_lines = false,
      icons = {
        expanded = "",
        collapsed = "",
        circular = "",
      },
      mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.50 },
            { id = "breakpoints", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 40,
          position = "right",
        },
        {
          elements = {
            "repl",
          },
          size = 0.25,
          position = "bottom",
        },
      },
      floating = {
        max_height = 0.9,
        max_width = 0.9,
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
    })

    dap.listeners.before.attach["dapui_config"] = function()
      dapui.open()
    end

    dap.listeners.before.launch["dapui_config"] = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end

  local function configure_telescope()
    local ok_telescope, telescope = pcall(require, "telescope")
    if not ok_telescope then
      return
    end

    pcall(telescope.load_extension, "dap")
  end

  local function configure_languages()
    if enabled.dap.go then
      pcall(function()
        require("plugins.dap.go").setup()
      end)
    end

    if enabled.dap.php then
      pcall(function()
        require("plugins.dap.php").setup()
      end)
    end
  end

  configure_signs()
  configure_virtual_text()
  configure_ui()
  configure_telescope()
  configure_languages()

  pcall(function()
    require("plugins.dap.keymaps").setup()
  end)
end

return M
