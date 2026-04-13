vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/ThePrimeagen/refactoring.nvim" },
})

require("refactoring").setup()

vim.keymap.set({ "n", "x" }, "<leader>ra", function()
  require("telescope").extensions.refactoring.refactors()
end, { desc = "Refactoring actions" })

vim.keymap.set({ "n", "x" }, "<leader>iv", function()
  require("refactoring").refactor("Extract Variable")
end, { desc = "Extract variable" })
