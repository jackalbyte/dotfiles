vim.api.nvim_create_user_command('Format', ':%!jq .', {})
vim.api.nvim_create_user_command('Unformat', ':%!jq -c .', {})

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

