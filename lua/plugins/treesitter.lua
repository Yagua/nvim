return {
  -- TS playground
  'nvim-treesitter/playground',

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'c',
        'cmake',
        'cpp',
        'go',
        'graphql',
        'java',
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
