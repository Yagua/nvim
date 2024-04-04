local setup_adapters = function(dap)
  local msn_path = vim.fn.stdpath('data') .. '/mason/packages/'

  -- Lua
  dap.adapters.nlua = function(callback, config)
    local port = config.port
    local opts = {
      args = {
        'new-window',
        '-n',
        '[Lua Debugger]',
        vim.v.progpath,
        '-c',
        string.format("lua require('osv').launch({port = %d})", port),
      },
      cwd = vim.fn.getcwd(),
      detached = true,
    }

    local handle
    local pid_or_err
    handle, pid_or_err = vim.loop.spawn('tmux', opts, function(code)
      handle:close()
      if code ~= 0 then
        print('nvim exited', code)
      end
    end)

    assert(handle, 'Could not run command:' .. pid_or_err)
    vim.cmd('sleep')
    callback({ type = 'server', host = '127.0.0.1', port = port })
  end

  dap.configurations.lua = {
    {
      name = 'Attach to running Neovim instance',
      type = 'nlua',
      request = 'attach',
      port = 44444,
    },
  }

  -- -- Java
  dap.configurations.java = {
    {
      name = 'Debug',
      type = 'java',
      request = 'launch',
      program = '${file}',
    },
    {
      name = 'Debug With Args',
      type = 'java',
      request = 'launch',
      program = '${file}',
      args = function()
        return vim.fn.trim(vim.fn.input("VM args: "))
      end,
    },
    {
      name = 'Debug (Attach) - Remote',
      type = 'java',
      request = 'attach',
      hostName = '127.0.0.1',
      port = 5005,
    },
  }

  -- Node
  dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = { msn_path .. 'node-debug2-adapter/out/src/nodeDebug.js' },
  }

  dap.configurations.javascript = {
    {
      name = 'Launch',
      type = 'node2',
      request = 'launch',
      program = '${file}',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      name = 'Attach to process',
      type = 'node2',
      request = 'attach',
      processId = require('dap.utils').pick_process,
    },
  }

  dap.configurations.typescript = {
    {
      name = 'ts-node (Node2 with ts-node)',
      type = 'node2',
      request = 'launch',
      cwd = vim.loop.cwd(),
      runtimeExecutable = 'node',
      runtimeArgs = { '-r', 'ts-node/register' },
      args = { '--inspect', '${file}' },
      sourceMaps = true,
      skipFiles = { '<node_internals>/**', 'node_modules/**' },
    },
    {
      name = 'Jest (Node2 with ts-node)',
      type = 'node2',
      request = 'launch',
      cwd = vim.loop.cwd(),
      runtimeExecutable = 'node',
      runtimeArgs = { '--inspect-brk', '${workspaceFolder}/node_modules/.bin/jest' },
      args = { '${file}', '--runInBand', '--coverage', 'false' },
      sourceMaps = true,
      port = 9229,
      skipFiles = { '<node_internals>/**', 'node_modules/**' },
    },
  }

  -- Python
  require('dap-python').setup(msn_path .. 'debugpy/venv/bin/python')
end

return {
  -- Debug adapters
  'leoluz/nvim-dap-go',
  'mfussenegger/nvim-dap-python',
  'jbyuki/one-small-step-for-vimkind',

  -- Dap
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio'
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      local ui_opts = { reset = true }
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open(ui_opts)
      end
      -- dap.listeners.before.event_terminated['dapui_config'] = function()
      --   dapui.close(ui_opts)
      -- end
      -- dap.listeners.before.event_exited['dapui_config'] = function()
      --   dapui.close(ui_opts)
      -- end
      setup_adapters(dap)

      require('utils').set_keymap({
        {
          'n',
          '<leader>dB',
          function()
            dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
          end,
        },
        { 'n', '<leader>db', dap.toggle_breakpoint },
        {
          'n',
          '<leader>de',
          function()
            dap.set_exception_breakpoints({ 'all' })
          end,
        },
        { 'n', '<leader>co', dap.continue },
        { 'n', '<leader>si', dap.step_into },
        { 'n', '<leader>so', dap.step_out },
        { 'n', '<leader>sq', dap.step_over },
        { 'n', '<leader>rc', dap.run_to_cursor },
        { 'n', '<leader>rf', dap.restart_frame },
        { 'n', '<leader>rl', dap.run_last },
        { 'n', '<F4>', dap.terminate },
        { 'n', '<leader>.', dap.close },
        {
          'n',
          '<leader>dc',
          function()
            dapui.close(ui_opts)
          end,
        },
        {
          'n',
          '<Home>',
          function()
            dapui.toggle({ layout = 1, reset = true })
          end,
        },
        {
          'n',
          '<End>',
          function()
            dapui.toggle({ layout = 2, reset = true })
          end,
        },
        {
          'n',
          '<leader>sw',
          function()
            if dap.session() then
              vim.api.nvim_command('DapUiFloat')
            end
          end,
        },
      })
    end,
  },

  -- Dap ui
  {
    'rcarriga/nvim-dap-ui',
    opts = {
      icons = { expanded = ' ', collapsed = ' ', current_frame = ' ' },
      mappings = { expand = { '<Tab>' } },
      layouts = {
        {
          elements = {
            --Elements can be strings or table with id and size keys.
            'watches',
            { id = 'scopes', size = 0.34 },
            { id = 'stacks', size = 0.34 },
          },
          size = 38,
          position = 'left',
        },
        {
          elements = {
            'repl',
            'console',
          },
          size = 10,
          position = 'bottom',
        },
      },
    },
  },
}
