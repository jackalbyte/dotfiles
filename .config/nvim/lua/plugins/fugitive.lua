vim.pack.add({'https://github.com/tpope/vim-fugitive'})

vim.keymap.set("n", "<leader>vs", ":tab Git<CR>", { desc = "Git Tab" })
vim.keymap.set("n", "<leader>va", ":Git blame<CR>", { desc = "Git Blame" })

