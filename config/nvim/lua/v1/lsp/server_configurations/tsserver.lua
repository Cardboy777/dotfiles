return {
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = 'vue-language-server',
        languages = { 'vue' },
      },
    },
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}
