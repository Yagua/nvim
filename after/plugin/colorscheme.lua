--Colorscheme Settings
local nebulous = require("nebulous")
local scheme = require("nebulous.functions").get_colors("fullmoon")

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
    LineNr =       { fg = scheme.Blue,   bg = scheme.none, style = scheme.none },
    CursorLineNr = { fg = scheme.Yellow, bg = scheme.none, style = scheme.none },
    TelescopeResultsBorder = { fg = scheme.DarkGrey_2, bg = scheme.none, style = scheme.none },
    TelescopePreviewBorder = { fg = scheme.DarkGrey_2, bg = scheme.none, style = scheme.none },
    TelescopePromptBorder =  { fg = scheme.DarkGrey_2, bg = scheme.none, style = scheme.none },
    TelescopeBorder =        { fg = scheme.DarkGrey_2, bg = scheme.none, style = scheme.none },
  }
}
