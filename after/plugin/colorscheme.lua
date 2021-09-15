--Colorscheme Settings
require("nebulous").setup {
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
  }
}
