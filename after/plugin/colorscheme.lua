-- Colorscheme Settings
local nebulous = require("nebulous")
local scheme = require("nebulous.functions").get_colors("nova")

nebulous.setup {
  variant = "nova",
  disable = {
    background = false,
    endOfBuffer = false,
    terminal_colors = false,
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
    -- highlight groups for custom status line
    StatusLineWarn = { fg = scheme.DarkOrange, bg = scheme.Grey, scheme.none },
    StatusLineModes = { fg = scheme.Aqua, bg = scheme.none, scheme.none },
    --Fidget
    FidgetTitle = { fg = scheme.DarkOrange, bg = scheme.none, style = scheme.none },
  }
}
