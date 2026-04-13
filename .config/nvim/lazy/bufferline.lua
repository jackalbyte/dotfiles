return {
  'akinsho/nvim-bufferline.lua',
  event = 'BufReadPre',
  config = function()
    local default_opts = {}
    vim.keymap.set("n", "<leader><Tab>", ":BufferLinePick<CR>", default_opts)
    require("bufferline").setup {
      options = {
        mode = "buffers",
        numbers = "ordinal",
        diagnostics = "nvim_lsp",
        separator_style = "thin",
        show_tab_indicators = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true,
      },
    }
  end,
}
