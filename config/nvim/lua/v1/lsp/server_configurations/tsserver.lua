local language_server_location = require('mason-registry').get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'

return {
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = language_server_location,
        languages = { 'vue' },
      },
    },
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}
