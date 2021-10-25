local M = {}
local HOME = os.getenv('HOME')
local server_cmd =  string.format('%s/.local/servers/jdtls/jdtls', HOME)

function M.setup()
  -- Utils
  require('jdtls').setup_dap()
  require('jdtls.setup').add_commands()

  -- Mappings
  local keymap = function(type, key, value)
    vim.api.nvim_buf_set_keymap(0, type, key, value, {noremap = true, silent = true});
  end

  keymap('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
  keymap('n','<leader>du','<cmd>lua vim.lsp.buf.definition()<CR>')
  keymap('n','<leader>re','<cmd>lua vim.lsp.buf.references()<CR>')
  keymap('n','<leader>vi','<cmd>lua vim.lsp.buf.implementation()<CR>')
  keymap('n','<leader>sh','<cmd>lua vim.lsp.buf.signature_help()<CR>')
  keymap('n','<leader>gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
  keymap('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  keymap('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
  -- ACTION mappings
  keymap('n','<leader>ah',  '<cmd>lua vim.lsp.buf.hover()<CR>')
  keymap('n','<leader>ca', '<cmd>lua require("jdtls").code_action()<CR>')
  keymap('n','<leader>rn',  '<cmd>lua vim.lsp.buf.rename()<CR>')
  -- Few language severs support these three
  keymap('n','<leader>=',  '<cmd>lua vim.lsp.buf.formatting()<CR>')
  keymap('n','<leader>ai',  '<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
  keymap('n','<leader>ao',  '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
  -- Diagnostics mapping
  keymap('n','<leader>ee', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
  keymap('n','<leader>en', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
  keymap('n','<leader>es', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
  -- Jdtls keymaps
  keymap("n", "<leader>oi", "<Cmd>lua require'jdtls'.organize_imports()<CR>")
  keymap("n", "<leader>av", "<Cmd>lua require'jdtls'.test_class()<CR>")
  keymap("n", "<leader>av", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>")
  keymap("v", "<leader>am", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR")
  keymap("n", "<leader>ar", "<Cmd>lua require('jdtls').extract_variable()<CR>")
  keymap("v", "<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>")

  -- Root dir config
  local root_markers = { 'pom.xml', 'build.gradle' }
  local root_dir = require('jdtls.setup').find_root(root_markers)
  local workspace_folder = string.format(
    "%s/.workspace/ws-%s", HOME, vim.fn.fnamemodify(root_dir, ":p:h:t")
  )

  -- Jdtls configs
  local config = {
    --flags = { allow_incremental_sync = true }
  }

  config.settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-1.8",
            path = "/opt/Java/jdk1.8.0_111",
          },
          {
            name = "JavaSE-11",
            path = "/opt/Java/jdk-11.0.12/",
          },
          {
            name = "JavaSE-14",
            path = "/opt/Java/jdk-14.0.2/"
          },
        }
      }
    }
  }
  -- CMD
  config.cmd = { server_cmd, workspace_folder }
  local bundles = {
    vim.fn.glob(HOME .. "/.local/dev_tools/java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"),
  }
  vim.list_extend(bundles, vim.split(vim.fn.glob(HOME .. "/.local/dev_tools/java/vscode-java-test/server/*.jar"), "\n"))
  config['init_options'] = {
    bundles = bundles
  }

  --UI
  require('jdtls.ui').pick_one_async = function (items, _, _, cb)
    require'lsputil.codeAction'.code_action_handler(nil, items, nil, nil, cb)
  end

  --Setup client
  require('jdtls').start_or_attach(config)
end

return M
