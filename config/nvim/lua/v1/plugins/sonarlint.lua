return {
  'schrieveslaach/sonarlint.nvim',
  url = 'https://gitlab.com/schrieveslaach/sonarlint.nvim',
  config = function()
    --[[   local isWindows = vim.fn.has('win32') == 1
    local wimdowsPath = 'C:/Users/rkippenbrock/AppData/Local/nvim-data/mason/share/sonarlint-cli/sonarlint-cli.jar'
    local unixPath = '/home/reid/.local/share/nvim/mason/bin/sonarlint-cli.jar'
    require('sonarlint').setup({
      server = {
        cmd = {
          'C:/Users/rkippenbrock/AppData/Local/nvim-data/mason/packages/sonarlint-language-server/sonarlint-language-server.cmd',
          -- Ensure that sonarlint-language-server uses stdio channel
          '-stdio',
          '-analyzers',
          -- paths to the analyzers you need, using those for python and java in this example
          'C:/Users/rkippenbrock/AppData/Local/nvim-data/mason/share/sonarlint-analyzers/sonarpython.jar',
          'C:/Users/rkippenbrock/AppData/Local/nvim-data/mason/share/sonarlint-analyzers/sonarlintomnisharp.jar',
          'C:/Users/rkippenbrock/AppData/Local/nvim-data/mason/share/sonarlint-analyzers/sonarjs.jar',
          'C:/Users/rkippenbrock/AppData/Local/nvim-data/mason/share/sonarlint-analyzers/sonarhtml.jar',
          'C:/Users/rkippenbrock/AppData/Local/nvim-data/mason/share/sonarlint-analyzers/sonartext.jar',
        },
        settings = {
          disableTelemetry = true,
          connectedMode = {
            connections = {
              sonarcloud = {
                {
                  connectionId = 'OnBoard',
                  disableNotifications = true,
                  organizationKey = 'onboardmeetings',
                },
              },
            },
          },
        },
      },
      filetypes = {
        'python',
        'javascript',
        'typescript',
        'vue',
        'c_sharp',
      },
    }) ]]
  end,
}
