return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    dependencies = {
      { "reasonml-editor/tree-sitter-reason" }
    },
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
    },
    config = function(_, opts)
      if opts.ensure_installed and #opts.ensure_installed > 0 then
        require("nvim-treesitter").install(opts.ensure_installed)
        for _, parser in ipairs(opts.ensure_installed) do
          local filetypes = parser
          vim.treesitter.language.register(parser, filetypes)
        end
      end

      local group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        callback = function(args)
          local bufnr = args.buf
          local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
          if not ok or not parser then
            return
          end
          pcall(vim.treesitter.start)
        end,
      })

    end,
  },
}
