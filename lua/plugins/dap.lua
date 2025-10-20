local setup_adapters = function(dap)
  local msn_path = vim.fn.stdpath('data') .. '/mason/packages/'

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
      hostName = function ()
        local DEFAULT_HOST_NAME = "127.0.0.1"
        local target_host_name = vim.fn.trim(
          vim.fn.input(string.format("Host (empty for default -> %s): ", DEFAULT_HOST_NAME))
          )
        return vim.fn.empty(target_host_name) > 0 and DEFAULT_HOST_NAME or target_host_name
      end,
      port = function ()
        local DEFAULT_PORT = "5005"
        local target_port = vim.fn.trim(
          vim.fn.input(string.format("Port: (empty for default -> %s): ", DEFAULT_PORT))
        )
        return vim.fn.empty(target_port) > 0 and DEFAULT_PORT or target_port
      end,
    },
  }

  require('dap-python').setup(msn_path .. 'debugpy/venv/bin/python')
  require('dap-go').setup {
    dap_configurations = {
      {
        type = "go",
        name = "Attach remote",
        mode = "remote",
        request = "attach",
      },
    },
    delve = {
      path = "dlv",
      initialize_timeout_sec = 20,
      port = "${port}",
      args = {},
      build_flags = "",
      detached = true,
      cwd = nil,
    },
  }
end

return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'mfussenegger/nvim-dap-python',
      'jbyuki/one-small-step-for-vimkind',
      'leoluz/nvim-dap-go',
    },
    config = function()
      local dap = require('dap')

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
      })
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      dapui.setup()

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end

      -- dap.listeners.before.event_terminated['dapui_config'] = function()
      --   dapui.close()
      -- end
      -- dap.listeners.before.event_exited['dapui_config'] = function()
      --   dapui.close()
      -- end
    end,
    keys = {
      { "<leader>dc", function() require('dapui').close() end, desc = "DAP: Close UI" },
      { "<Home>",     function() require('dapui').toggle({ layout = 1, reset = true }) end, desc = "DAP: UI Layout 1" },
      { "<End>",      function() require('dapui').toggle({ layout = 2, reset = true }) end, desc = "DAP: UI Layout 2" },
      { "<leader>sw", function() if require('dap').session() then require('dapui').float_element() end end, desc = "DAP: UI Float" },
    },
  },
}
