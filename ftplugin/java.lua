local set_keymap = require('utils').set_keymap
local home = os.getenv('HOME')
local jdtls = require('jdtls')
local root_markers = { '.gradlew', '.mvnw', '.git' }
local root_dir = jdtls.setup.find_root(root_markers)
local workspace_folder = string.format('%s/.local/share/eclipse/%s', home, vim.fn.fnamemodify(root_dir, ':p:h:t'))

-- Global build of clients' capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Extended capabilities
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.onCompletionItemSelectedCommand = "editor.action.triggerParameterHints"
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local msn_path = vim.fn.stdpath('data') .. '/mason/packages/'
local bundles = {
  vim.fn.glob(msn_path .. 'java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar'),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(msn_path .. 'java-test/extension/server/*.jar'), '\n'))

local resolve_jdtls_config = function()
  local uname = vim.loop.os_uname()
  local sysname = uname.sysname
  local machine = uname.machine

  if sysname == 'Darwin' then
    if machine == 'arm64' then
      return 'config_mac_arm'
    else
      return 'config_mac'
    end
  elseif sysname == 'Linux' then
    if machine == 'arm64' then
      return 'config_linux_arm'
    else
      return 'config_linux'
    end
  else
    return nil
  end
end

local trigger_test_func = function(callback)
  return function()
    if vim.bo.modified then
      vim.cmd('w')
    end
    callback()
  end
end

local config = {
  init_options = {
    bundles = bundles,
    extendedClientCapabilities = extendedClientCapabilities,
  },
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 100,
    allow_incremental_sync = true,
  },
  handlers = { ['language/status'] = function() end },
  cmd = {
    os.getenv("JAVA_21") .. '/bin/java',
    '-javaagent:' .. msn_path .. 'jdtls/lombok.jar',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    vim.fn.glob(msn_path .. 'jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration',
    msn_path .. 'jdtls/' .. resolve_jdtls_config(),
    '-data',
    workspace_folder,
  },
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      gradle = {
        enabled = true,
      },
      signatureHelp = { enabled = false },
      completion = {
        favoriteStaticMembers = {
          'org.assertj.core.api.Assertions.assertThat',
          'org.assertj.core.api.Assertions.assertThatThrownBy',
          'org.assertj.core.api.Assertions.assertThatExceptionOfType',
          'org.assertj.core.api.Assertions.catchThrowable',
          'org.hamcrest.MatcherAssert.assertThat',
          'org.hamcrest.Matchers.*',
          'org.hamcrest.CoreMatchers.*',
          'org.junit.jupiter.api.Assertions.*',
          'java.util.Objects.requireNonNull',
          'java.util.Objects.requireNonNullElse',
          'org.mockito.Mockito.*',
        },
        filteredTypes = {
          'com.sun.*',
          'io.micrometer.shaded.*',
          'java.awt.*',
          'jdk.*',
          'sun.*',
        },
      },
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-11',
            path = os.getenv('JAVA_11'),
          },
          {
            name = 'JavaSE-14',
            path = os.getenv('JAVA_14'),
          },
          {
            name = 'JavaSE-17',
            path = os.getenv('JAVA_17'),
          },
          {
            name = 'JavaSE-21',
            path = os.getenv('JAVA_21'),
          },
        },
      },
    },
  },
  on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
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
      { 'n', '<leader>gp', function () vim.diagnostic.jump({count = -1, float = true}) end, opts },
      { 'n', '<leader>gn', function () vim.diagnostic.jump({count = 1, float = true}) end, opts },
      -- jdtls
      { 'n', '<leader>or', jdtls.organize_imports, opts },
      { 'n', '<leader>am', jdtls.extract_variable, opts },
      { 'n', '<leader>om', jdtls.extract_constant, opts },
      { 'v', '<leader>am', "[[<ESC><CMD>lua require('jdtls').extract_variable(true)<CR>]]", opts },
      { 'v', '<leader>om', "[[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]]", opts },
      { 'v', '<leader>dm', "[[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]]", opts },
      -- Testing
      { 'n', '<leader>tc', trigger_test_func(jdtls.test_class), opts, },
      { 'n', '<leader>tn', trigger_test_func(jdtls.test_nearest_method), opts, },
      --Custom
      {
        'n',
        '<leader>~',
        function()
          vim.notify("[LSP]: restarting server...", vim.log.levels.WARN)
          require('jdtls.setup').restart()
        end,
        opts,
      },
    })
  end,
}

jdtls.start_or_attach(config)
