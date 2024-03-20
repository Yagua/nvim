return {
  {
    'Yagua/nebulous.nvim',
    lazy = false,
    priority = 1000,
    -- dev = true,
    opts = {
      variant = 'night',
      disable = {
        background = false,
        endOfBuffer = false,
      },
      italic = {
        comments = true,
        keywords = true,
        functions = false,
        variables = false,
      },
    },
    config = function(_, opts)
      local scheme = require('nebulous.functions').get_colors('midnight')
      opts = vim.tbl_deep_extend('force', {
        custom_colors = {
          LineNr = { fg = scheme.Blue, bg = scheme.none, style = scheme.none },
          CursorLineNr = { fg = scheme.Yellow, bg = scheme.none, style = scheme.none },
        },
      }, opts)
      require('nebulous').setup(opts)
    end,
  },
}
