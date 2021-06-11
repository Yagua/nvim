local M = {}
local HOME = os.getenv('HOME')
local server_cmd =  string.format('%s/.local/servers/jdtls/jdtls', HOME)

--Main function
function M.setup()

  --Function that will always be executed with the client
  local on_attach = function(client, bufnr)
    require('jdtls.setup').add_commands()
    --require('lsp-status').register_progress()
    --require('jdtls').setup_dap()

    -- Mappings
    local function buf_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap = true, silent = true }

    buf_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_keymap('n', '<leader>du', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_keymap('n', '<leader>re', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_keymap('n', '<leader>vi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_keymap('n', '<leader>sh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_keymap('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_keymap('n', '<leader>gw', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
    buf_keymap('n', '<leader>gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
    -- Action mappings
    buf_keymap('n', '<leader>ah', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_keymap('n', '<leader>ca', '<cmd>lua require("jdtls").code_action()<CR>)', opts)
    buf_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- Few language severs support these three
    buf_keymap('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    buf_keymap('n', '<leader>ai', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
    buf_keymap('n', '<leader>ao', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)
    -- Diagnostics mapping
    buf_keymap('n', '<leader>ee', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_keymap('n', '<leader>en', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_keymap('n', '<leader>es', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    --Jdtls keymaps
    buf_keymap("n", "<leader>oi", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
    buf_keymap("n", "<leader>av", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
    buf_keymap("n", "<leader>av", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
    buf_keymap("v", "<leader>am", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
    buf_keymap("n", "<leader>ar", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
    buf_keymap("v", "<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
  end

  --Root dir config
  local root_markers = { 'gradlew', 'pom.xml', 'build.gradle' }
  local root_dir = require('jdtls.setup').find_root(root_markers)
  local workspace_folder = string.format(
    "%s/.workspace/ws-%s", HOME, vim.fn.fnamemodify(root_dir, ":p:h:t")
  )

  -- jdtls configs
  local config = {
    flags = { allow_incremental_sync = true };
    on_attach = on_attach,
  }

  config.settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-14",
            path = "/opt/jdk-14.0.2/"
          },
          {
            name = "JavaSE-1.8",
            path = "/opt/jdk1.8/",
          }
        }
      }
    }
  }

  config.cmd = { server_cmd, workspace_folder }

  --Setup client
  require('jdtls').start_or_attach(config)

end

return M
