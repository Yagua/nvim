local tags = "-tags=wireinject,integration"

return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      {
        'fredrikaverpil/neotest-golang',
        dependencies = {
          "uga-rosa/utf8.nvim",
        },
        build = function()
          vim.system({ 'go', 'install', 'gotest.tools/gotestsum@latest' }):wait()
        end,
      },
    },
    keys = {
      {
        '<leader>ta',
        function()
          require('neotest').run.attach()
        end,
        desc = 'Attach',
      },
      {
        '<leader>tf',
        function()
          require('neotest').run.run(vim.fn.expand('%'))
        end,
        desc = 'Run File',
      },
      {
        '<leader>tA',
        function()
          require('neotest').run.run(vim.uv.cwd())
        end,
        desc = 'Run All Test Files',
      },
      {
        '<leader>tT',
        function()
          require('neotest').run.run({ suite = true })
        end,
        desc = 'Run Test Suite',
      },
      {
        '<leader>tn',
        function()
          require('neotest').run.run()
        end,
        desc = 'Run Nearest',
      },
      {
        '<leader>tL',
        function()
          require('neotest').run.run_last()
        end,
        desc = 'Run Last',
      },
      {
        '<leader>ts',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Toggle Summary',
      },
      {
        '<leader>tO',
        function()
          require('neotest').output.open({ enter = true, auto_close = true })
        end,
        desc = 'Show Output',
      },
      {
        '<leader>oc',
        function()
          require('neotest').output_panel.clear()
        end,
        desc = 'Clear Output Panel',
      },
      {
        '<leader>to',
        function()
          require('neotest').output_panel.toggle()
        end,
        desc = 'Toggle Output Panel',
      },
      {
        '<leader>tt',
        function()
          require('neotest').run.stop()
        end,
        desc = 'Terminate',
      },
      {
        '<leader>dt',
        function()
          require('neotest').summary.close()
          require('neotest').output_panel.close()
          require('neotest').run.run({ suite = false, strategy = 'dap' })
        end,
        desc = 'Debug nearest test',
      },
      {
        '<leader>dT',
        function()
          require('neotest').summary.close()
          require('neotest').output_panel.close()
          require('neotest').run.run({ vim.fn.expand('%'), suite = false, strategy = 'dap' })
        end,
        desc = 'Debug current file',
      },
    },
    config = function()
      require('neotest').setup({
        discovery = { enabled = true, concurrent = 0 },
        running = { concurrent = true },
        summary = { animated = true },
        diagnostic = { enabled = true },
        adapters = {
          require('neotest-golang')({
            runner = 'gotestsum',
            gotestsum_args = { '--format=standard-verbose' },
            go_list_args = { tags },
            go_test_args = {
              '-v',
              '-count=1',
              '-race',
              '-coverprofile=' .. vim.fn.getcwd() .. '/coverage.out',
              -- "-p=1",
              '-parallel=1',
              tags,
            },
          }),
        },
      })
    end,
  },
}
