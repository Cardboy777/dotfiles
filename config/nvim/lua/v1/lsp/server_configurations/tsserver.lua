return {
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = require('mason-registry').get_package('vue-language-server'):get_install_path(),
        languages = { 'vue' },
      },
    },
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}
