vim.pack.add({
  "https://github.com/ellisonleao/gruvbox.nvim"
})

local p = require("gruvbox").palette
local plain = { fg = p.light1, bold = false, italic = false }

require("gruvbox").setup({
  overrides = {
    -- Only comments, strings, constants and numbers get color.
    Comment = { fg = p.bright_yellow, italic = true },
    String = { fg = p.bright_aqua },
    Constant = { fg = p.bright_blue },
    Number = { fg = p.bright_purple },
    Float = { fg = p.bright_purple },

    -- Everything else is plain text.
    Boolean = plain,
    Character = plain,
    Identifier = plain,
    Function = plain,
    Statement = plain,
    Conditional = plain,
    Repeat = plain,
    Label = plain,
    Operator = plain,
    Keyword = plain,
    Exception = plain,
    PreProc = plain,
    Include = plain,
    Define = plain,
    Macro = plain,
    PreCondit = plain,
    Type = plain,
    StorageClass = plain,
    Structure = plain,
    Typedef = plain,
    Special = plain,
    SpecialChar = plain,
    Tag = plain,
    Delimiter = plain,
    SpecialComment = plain,

    ["@constructor"] = plain,
    ["@constant.builtin"] = plain,
    ["@function"] = plain,
    ["@function.method"] = plain,
    ["@function.method.call"] = plain,
    ["@function.builtin"] = plain,
    ["@keyword"] = plain,
    ["@keyword.import"] = plain,
    ["@keyword.exception"] = plain,
    ["@keyword.operator"] = plain,
    ["@keyword.return"] = plain,
    ["@keyword.conditional"] = plain,
    ["@keyword.function"] = plain,
    ["@keyword.repeat"] = plain,
    ["@operator"] = plain,
    ["@punctuation"] = plain,
    ["@punctuation.bracket"] = plain,
    ["@punctuation.delimiter"] = plain,
    ["@parameter"] = plain,
    ["@property"] = plain,
    ["@type"] = plain,
    ["@type.builtin"] = plain,
    ["@variable"] = plain,
    ["@variable.builtin"] = plain,
    ["@variable.member"] = plain,
    ["@variable.parameter"] = plain,
    ["@boolean"] = plain,
    ["@module"] = plain,
    ["@tag"] = plain,
    ["@tag.attribute"] = plain,
    ["@tag.delimiter"] = plain,

    ["@string"] = { fg = p.bright_aqua },
    ["@constant"] = { fg = p.bright_blue },
    ["@number"] = { fg = p.bright_purple },
    ["@number.float"] = { fg = p.bright_purple },
    ["@comment"] = { fg = p.bright_yellow, italic = true },

    DiagnosticError = { fg = p.bright_red },
    DiagnosticWarn = { fg = p.bright_yellow },
  },
})
vim.cmd.colorscheme("gruvbox")
