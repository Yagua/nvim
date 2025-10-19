return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'c',
        'cmake',
        'cpp',
        'go',
        'gomod',
        'gosum',
        'gowork',
        'graphql',
        'java',
        'groovy',
        'javascript',
        'lua',
        'markdown',
        'markdown_inline',
        'python',
        'rust',
        'sql',
        'tsx',
        'typescript',
        'zig',
      },
      highlight = { enable = true },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false,
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
