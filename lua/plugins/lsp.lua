local set_keymap = require('utils').set_keymap

-- Global build of clients' capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- Floating preview window's borders
local original_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = 'rounded' -- to force the rounded in everything
  return original_util_open_floating_preview(contents, syntax, opts, ...)
end

local setup_lsp_keymaps = function(opts)
  set_keymap({
    { 'n', 'gD', vim.lsp.buf.declaration, opts },
    { 'n', '<leader>du', vim.lsp.buf.definition, opts },
    { 'n', '<leader>re', vim.lsp.buf.references, opts },
    { 'n', '<leader>vi', vim.lsp.buf.implementation, opts },
    { 'n', '<leader>sh', vim.lsp.buf.signature_help, opts },
    { 'i', '<C-s>',      vim.lsp.buf.signature_help, opts },
    { 'n', '<leader>gt', vim.lsp.buf.type_definition, opts },
    { 'n', '<leader>gw', vim.lsp.buf.document_symbol, opts },
    { 'n', '<leader>gW', vim.lsp.buf.workspace_symbol, opts },
    --Actions mappings
    { 'n', '<leader>ah', vim.lsp.buf.hover, opts },
    { 'n', '<leader>ca', vim.lsp.buf.code_action, opts },
    { 'n', '<leader>rn', vim.lsp.buf.rename, opts },
    -- Few language severs support these three
    { 'n', '<leader>=', function() vim.lsp.buf.format({ async = true }) end, opts, },
    { 'n', '<leader>ai', vim.lsp.buf.incoming_calls, opts },
    { 'n', '<leader>ao', vim.lsp.buf.outgoing_calls, opts },
    --Diagnostics mappings
    { 'n', '<leader>ee', vim.diagnostic.open_float, opts },
    { 'n', '<leader>gp', function () vim.diagnostic.jump({count = -1}) end, opts },
    { 'n', '<leader>gn', function () vim.diagnostic.jump({count = 1}) end, opts },
    --Custom
    {
      'n',
      '<leader>~',
      function()
        vim.notify("[LSP]: restarting server...", vim.log.levels.WARN)
        vim.cmd("LspRestart")
      end,
      opts
    },
    {
      "n",
      "<leader>tl",
      function ()
        local config = vim.diagnostic.config() or {}
        if config.virtual_text then
          vim.diagnostic.config { virtual_text = false, virtual_lines = true }
        else
          vim.diagnostic.config { virtual_text = true, virtual_lines = false }
        end
      end,
      opts
    },
  })
end

return {
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    opts = {
      ui = {
        border = 'rounded',
        width = 0.9,
        height = 0.9,
      },
    },
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      ensure_installed = {
        'debugpy',
        -- 'node-debug2-adapter',
        'java-test',
        'java-debug-adapter',
        'jdtls',
        'css-lsp',
        'html-lsp',
        'gopls',
        'json-lsp',
        'lua-language-server',
        'shfmt',
        'stylua',
        'codelldb',
        'taplo',
        'typescript-language-server',
        'vim-language-server',
        'yaml-language-server',
        'sqlfluff',
        'dockerfile-language-server',
        'docker-compose-language-service',
        'zls',
        'eslint_d',
        "groovy-language-server"
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "luvit-meta/library", words = { "vim%.uv" } },
          },
        },
      },
      { "Bilal2453/luvit-meta", lazy = true },
      'williamboman/mason-lspconfig.nvim',
    },
    opts = {
      autoformat = true,
      diagnostics = {
        underline = true,
        severity_sort = true,
        update_in_insert = false,
        virtual_text = {
          prefix = "■",
          spacing = 2,
          source = "if_many"
        }
      },
      servers = {
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pycodestyle = {
                  enabled = false,
                }
              }
            }
          }
        },
        ts_ls = {},
        cssls = {},
        yamlls = {},
        vimls = {},
        taplo = {},
        zls = {},
        jsonls = {},
        dockerls = {},
        docker_compose_language_service = {},
        groovyls = {},

        lua_ls = { },

        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
            },
          },
        },

        clangd = {
          cmd = {
            'clangd',
            '--background-index',
            '--suggest-missing-includes',
            '--clang-tidy',
            '--header-insertion=iwyu',
          },
          init_options = {
            clangdFileStatus = true,
          },
        },

        html = { filetypes = { 'html', 'jsp' } },
      },
    },
    config = function(_, opts)
      vim.diagnostic.config(opts.diagnostics)

      local keymaps_opts = { buffer = 0 }
      local default_on_attach = function()
        setup_lsp_keymaps(keymaps_opts)
      end

      vim.lsp.config("*", {
        capabilities = capabilities
      })

      -- Setup servers
      local servers = opts.servers
      for server, _ in pairs(servers) do
        local server_opts = vim.tbl_deep_extend('force', {
          on_attach = default_on_attach,
          flags = {
            debounce_text_changes = nil,
          },
        }, servers[server] or {})

        vim.lsp.config(server, server_opts)
        vim.lsp.enable(server)
      end
    end,
  },

  { 'mfussenegger/nvim-jdtls' },
}
