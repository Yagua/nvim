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
  })
end

return {
  --Mason
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    opts = {
      ui = {
        border = 'rounded',
        width = 0.9,
        height = 0.9,
      },
      ensure_installed = {
        'debugpy',
        'node-debug2-adapter',
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
        'typos-lsp',
        'eslint_d'
      },
    },
    config = function(_, opts)
      -- Helper to install tools via `ensure_installed` key
      require('mason').setup(opts)
      local mr = require('mason-registry')
      for _, tool in ipairs(opts.ensure_installed) do
        local pack = mr.get_package(tool)
        if not pack:is_installed() then
          pack:install()
        end
      end
    end,
  },

  -- Null-ls
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'mason.nvim' },
    opts = function()
      local nls = require('null-ls')
      return {
        border = 'rounded',
        debounce = 100,
        save_after_format = false,
        sources = {
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
          nls.builtins.diagnostics.zsh,
          nls.builtins.diagnostics.sqlfluff.with({
            extra_args = { '--dialect', 'mysql' },
          }),
        },
      }
    end,
  },

  --Lsp
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      { 'folke/neodev.nvim', opts = { experimental = { pathStrict = true } } },
    },
    opts = {
      autoformat = true,
      diagnostics = {
        underline = true,
        severity_sort = true,
      },
      servers = {
        -- Default
        pylsp = {},
        ts_ls = {},
        cssls = {},
        yamlls = {},
        vimls = {},
        taplo = {},
        zls = {},
        jsonls = {},
        dockerls = {},
        docker_compose_language_service = {},

        -- Lua
        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
              },
              workspace = { checkThirdParty = false },
              diagnostics = {
                globals = { 'vim' },
                unusedLocalExclude = { '_*' },
                groupSeverity = {
                  strong = 'Warning',
                  strict = 'Warning',
                },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = 'space',
                  indent_size = '2',
                  continuation_indent_size = '2',
                },
              },
              completion = {
                workspaceWord = true,
                callSnippet = 'Both',
              },
              semantic = { enable = false },
            },
          },
        },

        -- Go
        gopls = {
          cmd = { 'gopls', 'serve' },
          filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
          single_file_support = true,
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

        -- C/C++
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

        -- Html
        html = { filetypes = { 'html', 'jsp' } },
      },
    },
    config = function(_, opts)
      local keymaps_opts = { buffer = 0 }
      local default_on_attach = function()
        setup_lsp_keymaps(keymaps_opts)
      end
      -- Setup servers
      local servers = opts.servers
      local setup_server = function(server)
        local server_opts = vim.tbl_deep_extend('force', {
          on_attach = default_on_attach,
          capabilities = vim.deepcopy(capabilities),
          flags = {
            debounce_text_changes = nil,
          },
        }, servers[server] or {})
        require('lspconfig')[server].setup(server_opts)
      end

      require('mason-lspconfig').setup()
      for server, _ in pairs(servers) do
        setup_server(server)
      end
      require('neodev').setup()
    end,
  },

  -- Nvim-jdtls
  { 'mfussenegger/nvim-jdtls', lazy = false},

  -- go.nvim
  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local opts = { noremap = true}
      set_keymap({
        { 'n', '<Space>Gr', '<cmd>GoRun<CR>', opts },
        { 'n', '<Space>GA', '<cmd>GoModTidy<CR>', opts },
        { 'n', '<Space>Gb', '<cmd>GoBuild<CR>', opts},
        { 'n', '<Space>Gt', '<cmd>GoTestFunc<CR>', opts },
        { 'n', '<Space>GT', '<cmd>GoTestFile<CR>', opts },
        { 'n', '<Space>GC', '<cmd>GoCoverage -m<CR>', opts },
        { 'n', '<Space>Gp', '<cmd>GoTestPkg<CR>', opts },
        { 'n', '<Space>Gd', '<cmd>GoDoc<CR>', opts },
        { 'n', '<Space>Gf', '<cmd>GoFillStruct<CR>', opts },
        { 'n', '<Space>GD', '<cmd>GoDebug -t<CR>', opts },
        { 'n', '<Space>Gi', '<cmd>GoImports<CR>', opts },
        { 'n', '<Space>GF', '<cmd>GoFmt<CR>', opts },
        { 'n', '<Space>Ga', '<cmd>GoAddTest<CR>', opts },
        { 'n', '<Space>Gg', '<cmd>GoAddTag<CR>', opts },
        { 'n', '<Space>Gl', '<cmd>GoClearTag<CR>', opts },
        { 'n', '<Space>GI', '<cmd>GoImpl<CR>', opts },
        { 'n', '<Space>Ge', '<cmd>GoIfErr<CR>', opts },
        { 'n', '<Space>GR', '<cmd>GoGenReturn<CR>', opts },
        { 'n', '<Space>GL', '<cmd>GoToggleInlay<CR>', opts },
        { 'n', '<Space>Gm', '<cmd>GoCmt<CR>', opts },
      })
      require("go").setup({
          icons = false,
          lsp_keymaps = false,
          dap_debug_keymap = false,
          dap_debug_gui = false,
          dap_debug_vt = false
      })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  }
}
