return {
  settings = {
    redhat = {
      telemetry = { enabled = false },
    },
    yaml = {
      format = {
        enable = true,
        printWidth = 120,
      },
      schemaStore = {
        enable = false,
        url = '',
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}
