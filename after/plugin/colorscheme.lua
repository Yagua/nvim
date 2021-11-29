--Colorscheme Settings
local nebulous = require("nebulous")
nebulous.setup {
  variant = "fullmoon",
  disable = {
    background = false,
    endOfBuffer = false,
  },
  italic = {
    comments   = true,
    keywords   = false,
    functions  = false,
    variables  = false,
  },
  custom_colors = {
    LineNr =       { fg = "#5BBBDA", bg = "NONE", style = "NONE" },
    CursorLineNr = { fg = "#DCC03A", bg = "NONE", style = "NONE" },
    TelescopeResultsBorder = { fg = "#A5A6A9", bg = "NONE", style = "NONE" },
    TelescopePreviewBorder = { fg = "#A5A6A9", bg = "NONE", style = "NONE" },
    TelescopePromptBorder =  { fg = "#A5A6A9", bg = "NONE", style = "NONE" },
    TelescopeBorder =        { fg = "#A5A6A9", bg = "NONE", style = "NONE" },
  }
}
