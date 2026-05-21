-- https://github.com/nvim-lualine/lualine.nvim
return {
  'nvim-lualine/lualine.nvim',
  event = 'VimEnter',
  enabled = true,
  config = function()
    require('lualine').setup {
      options = {
        section_separators = '',
        component_separators = ''
      }
    }
  end,
}

