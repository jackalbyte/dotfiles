vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
})

local function get_visual_selection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end

local builtin = require('telescope.builtin')

vim.keymap.set("n", "<Leader>/", function()
  builtin.current_buffer_fuzzy_find({ fuzzy = false, case_mode = "ignore_case" })
end, {})

vim.keymap.set("n", "<Leader>ff", function()
  builtin.find_files({ hidden = true })
end, {})

vim.keymap.set("n", "<Leader>fs", function()
  builtin.live_grep({ hidden = true })
end, {})

vim.keymap.set("n", "<Leader>fw", function()
  builtin.grep_string()
end, {})

vim.keymap.set("n", "<Leader>fg", builtin.git_files, {})
vim.keymap.set("n", "<Leader>fb", builtin.buffers, {})

vim.keymap.set("n", "<leader>pg", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set("v", "<Leader>pg", function()
  builtin.grep_string({ search = get_visual_selection() })
end, {})

vim.keymap.set("n", "<Leader>vc", builtin.git_commits, {})
vim.keymap.set("n", "<Leader>vb", builtin.git_branches, {})
vim.keymap.set("n", "<Leader>vh", builtin.git_bcommits, {})

require("telescope").setup({
  defaults = {
    layout_config = {
      horizontal = {
        prompt_position = "top",
      },
    },
    extensions = {},
    path_display = { "smart" },
    sorting_strategy = "ascending",
    file_ignore_patterns = {
      ".git/",
      "target/",
      "docs/",
      "vendor/*",
      "%.lock",
      "__pycache__/*",
      "%.sqlite3",
      "%.ipynb",
      "node_modules/*",
      "%.jpg",
      "%.jpeg",
      "%.png",
      "%.svg",
      "%.otf",
      "%.ttf",
      "%.webp",
      ".dart_tool/",
      ".github/",
      ".gradle/",
      ".idea/",
      ".settings/",
      ".vscode/",
      "__pycache__/",
      "build/",
      "env/",
      "gradle/",
      "node_modules/",
      "%.pdb",
      "%.dll",
      "%.class",
      "%.exe",
      "%.cache",
      "%.ico",
      "%.pdf",
      "%.dylib",
      "%.jar",
      "%.docx",
      "%.met",
      "smalljre_*/*",
      ".vale/",
      "%.burp",
      "%.mp4",
      "%.mkv",
      "%.rar",
      "%.zip",
      "%.7z",
      "%.tar",
      "%.bz2",
      "%.epub",
      "%.flac",
      "%.tar.gz",
    },
  },
})

require("telescope").load_extension("ui-select")
