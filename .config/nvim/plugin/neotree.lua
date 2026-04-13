vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", branch = "v2.x" },
})

local builtin = require("neo-tree.command")

vim.keymap.set("n", "\\\\", function()
  builtin.execute({ toggle = true, reveal = true })
end, { desc = "Toggle neo-tree" })

require("neo-tree").setup({
  close_if_last_window = true,
  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = true,
    },
  },
  event_handlers = {
    {
      event = "file_opened",
      handler = function(_)
        builtin.execute({ action = "close" })
      end,
    },
  },
})
