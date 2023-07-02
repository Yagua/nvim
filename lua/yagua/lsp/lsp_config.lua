local lsp = require('lspconfig')
local jdtls = require("jdtls")
local M = {}
local HOME = os.getenv('HOME')
local msn_path = vim.fn.stdpath("data") .. "/mason/packages/"

--capabilities
local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
custom_capabilities.textDocument.completion.completionItem.snippetSupport = true
custom_capabilities = require("cmp_nvim_lsp").default_capabilities(custom_capabilities)

--keymaps
local key_maps = {
  {"n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()"},
  {"n", "<leader>du", "<cmd>lua vim.lsp.buf.definition()"},
  {"n", "<leader>re", "<cmd>lua vim.lsp.buf.references()"},
  {"n", "<leader>vi", "<cmd>lua vim.lsp.buf.implementation()"},
  {"n", "<leader>sh", "<cmd>lua vim.lsp.buf.signature_help()"},
  {"n", "<leader>gt", "<cmd>lua vim.lsp.buf.type_definition()"},
  {"n", "<leader>gw", "<cmd>lua vim.lsp.buf.document_symbol()"},
  {"n", "<leader>gW", "<cmd>lua vim.lsp.buf.workspace_symbol()"},
  -- ACTION mappings
  {"n", "<leader>ah", "<cmd>lua vim.lsp.buf.hover()"},
  {"n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()"},
  {"n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()"},
  -- Few language severs support these three
  {"n", "<leader>=",  "<cmd>lua vim.lsp.buf.format { async = true }"},
  {"n", "<leader>ai", "<cmd>lua vim.lsp.buf.incoming_calls()"},
  {"n", "<leader>ao", "<cmd>lua vim.lsp.buf.outgoing_calls()"},
  -- Diagnostics mapping
  {"n", "<leader>ee", "<cmd>lua vim.diagnostic.open_float()"},
  {"n", "<leader>gp", "<cmd>lua vim.diagnostic.goto_prev()"},
  {"n", "<leader>gn", "<cmd>lua vim.diagnostic.goto_next()"},
  -- Custom functions
  {"n", "<leader>en", "<cmd>lua require('yagua.lsp.util').diagnostics_qfixlist()"},
}

--set keymaps
local set_keymaps = function(km)
  local km_ops = {noremap = true, silent = true}
  for _, maps in pairs(km) do
    local mode, lhs, rhs = unpack(maps)
    vim.api.nvim_buf_set_keymap(0, mode, lhs, string.format("%s<CR>", rhs),
      km_ops);
  end
end

--on attach
local custom_attach = function(_)
  set_keymaps(key_maps)
end


local servers = {
  bashls = {},
  vimls = {},
  cssls = {},
  yamlls = {},
  rust_analyzer = {},
  sqlls = {},
  dockerls = {},

  html = {
    cmd = {"vscode-html-language-server", "--stdio"},
    filetypes = {
      "html",
      "jsp",
    }
  },

  tsserver = {
    cmd = {"typescript-language-server", "--stdio"},
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx"
    },
  },

  pylsp = {
    plugins = {
      pyls_mypy = {
        enabled = true,
        live_mode = false,
      },
    },
  },

  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--suggest-missing-includes",
      "--clang-tidy",
      "--header-insertion=iwyu",
    },
  },

  gopls = {
    cmd = { "gopls", "serve" },
    filetypes = { "go", "gomod" },
  },

  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = vim.split(package.path, ';')
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'}
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
          }
        }
      }
    },
  },
}

-- load servers and its configs
local load_servers = function (server, config)
  config = vim.tbl_deep_extend("force", {
    on_attach = custom_attach,
    capabilities = custom_capabilities
  }, config or {})

  lsp[server].setup(config)
end

--# Java
--custom jdtls_on_attach
local function jdtls_on_attach(_)
  jdtls.setup_dap({hotcodereplace = 'auto'})
  jdtls.setup.add_commands()

  local jdtls_keymaps = {
    {"n", "<leader>or", "<Cmd>lua require('jdtls').organize_imports()"},
    {"n", "<leader>av", "<Cmd>lua require('jdtls').test_class()"},
    {"n", "<leader>tm", "<Cmd>lua require('jdtls').test_nearest_method()"},
    {"v", "<leader>am", "<Esc><Cmd>lua require('jdtls').extract_variable(true)"},
    {"n", "<leader>am", "<Cmd>lua require('jdtls').extract_variable()"},
    {"n", "<leader>om", "<Cmd>lua require('jdtls').extract_constant()"},
    {"v", "<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)"},
  }

  local extended_keymaps = vim.fn.extend(key_maps, jdtls_keymaps)
  set_keymaps(extended_keymaps)
end

--setup jdtls
M.setup_jdtls = function()
  -- Root dir config
  local root_markers = {
    "gradlew",
    "mvnw",
    ".git",
    --'pom.xml',
    --'build.gradle'
  }
  local root_dir = jdtls.setup.find_root(root_markers)
  local workspace_folder = string.format(
    "%s/.local/share/eclipse/%s", HOME, vim.fn.fnamemodify(root_dir, ":p:h:t")
  )
  -- Jdtls configs
  local config = {
      handlers = {},
  }

  config.settings = {
    java = {
      signatureHelp = { enabled = true },
      completion = {
        favoriteStaticMembers = {
          "org.assertj.core.api.Assertions.assertThat",
          "org.assertj.core.api.Assertions.assertThatThrownBy",
          "org.assertj.core.api.Assertions.assertThatExceptionOfType",
          "org.assertj.core.api.Assertions.catchThrowable",
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
      },
    },
    configuration = {
      runtimes = {
        {
          name = "JavaSE-1.8",
          path = "/opt/jdks/jdk1.8.0_202",
        },
        {
          name = "JavaSE-11",
          path = "/opt/jdks/jdk-11.0.18",
        },
        {
          name = "JavaSE-14",
          path = "/opt/jdks/jdk-14.0.2"
        },
        {
          name = "JavaSE-17",
          path = "/opt/jdks/jdk-17.0.7"
        },
      }
    }
  }

  -- Cmd
  config.cmd = {
    "/opt/jdks/jdk-17.0.7/bin/java",
    "-javaagent:" .. msn_path .. "jdtls/lombok.jar",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", vim.fn.glob(msn_path .. "jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration", msn_path .. "jdtls/config_linux",
    "-data", workspace_folder,
  }

  config.on_attach = jdtls_on_attach
  config.capabilities = custom_capabilities

  local bundles = {
    vim.fn.glob(
      msn_path .. "java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
    )
  }
  vim.list_extend(
    bundles,
    vim.split(vim.fn.glob(msn_path .. "java-test/extension/server/*.jar"), "\n")
  )

  local extendedClientCapabilities = jdtls.extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

  config.init_options = {
    bundles = bundles,
    extendedClientCapabilities = extendedClientCapabilities;
  }

  -- mute progress (status bar shows this)
  config.handlers['language/status'] = function() end

  --Setup client
  jdtls.start_or_attach(config)
end

require("mason").setup({
  ui = {
    border = "rounded",
    width = 0.9,
    height = 0.9,
  },
})
require("mason-lspconfig").setup()
for server, config in pairs(servers) do
  load_servers(server, config)
end

return M
