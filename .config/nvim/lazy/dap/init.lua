return {
  'mfussenegger/nvim-dap',
  -- module = {'dap'},
  dependencies = {
    {"nvim-neotest/nvim-nio"},
    {'rcarriga/nvim-dap-ui'},
    -- require delve 'brew install delve' 
    {'leoluz/nvim-dap-go'},
    {'theHamsta/nvim-dap-virtual-text'},
    {'nvim-telescope/telescope-dap.nvim'},
  },
  config = function()
    local function configure()
      local dap_breakpoint = {
        breakpoint = {
          text = "󰃤",
          texthl = "LspDiagnosticsSignError",
          linehl = "",
          numhl = "",
        },
        rejected = {
          text = "󰨰",
          texthl = "LspDiagnosticsSignHint",
          linehl = "",
          numhl = "",
        },
        stopped = {
          text = "",
          texthl = "LspDiagnosticsSignInformation",
          linehl = "DiagnosticUnderlineInfo",
          numhl = "LspDiagnosticsSignInformation",
        },
      }

      vim.fn.sign_define("DapBreakpoint", dap_breakpoint.breakpoint)
      vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
      vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
    end

    local function configure_exts()
      require("nvim-dap-virtual-text").setup {
        commented = true,
      }

      local dap, dapui = require "dap", require "dapui"
      dapui.setup {
        expand_lines = false,
        icons = { expanded = "", collapsed = "", circular = "" },
        mappings = {
          -- Use a table to apply multiple mappings
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
              -- Elements can be strings or table with id and size keys.
              { id = "scopes", size = 0.50 },
              { id = "breakpoints", size = 0.25 },
              --{ id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40, -- 40 columns
            position = "right",
          },
          {
            elements = {
              "repl",
              --"console",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
          },
        },
        floating = {
          max_height = 0.9,
          max_width = 0.9, -- Floats will be treated as percentage of your screen.
          -- border = 'rounded', -- Border style. Can be 'single', 'double' or 'rounded'
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
      }

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end

    local function configure_debuggers()
      require("plugins.dap.go").setup()
    end

    configure()
    configure_exts()
    configure_debuggers()

    require("plugins.dap.keymaps").setup() -- Keymaps

  end,
}


