vim.pack.add({
  { src = 'https://github.com/echasnovski/mini.comment', branch = 'stable' }
})

require('mini.comment').setup({
  mappings = {
    comment = '<C-_>', -- it's actually <C-/>
    --comment_line = '<C-_>',
    textobject = '<C-_>',
  },
})
